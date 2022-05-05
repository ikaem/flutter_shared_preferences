import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_shared_preferences/http_helper.dart';
import 'package:flutter_shared_preferences/pizza.dart';
import 'package:flutter_shared_preferences/pizza_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:path_provider/path_provider.dart";
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pwdController = TextEditingController();

  int _counter = 0;
  int _appCounter = 0;
  String documentPath = "";
  String tempPath = "";
  late File myFile;
  String fileText = "";
  final storage = FlutterSecureStorage();
  final myKey = "myPass";
  String? myPass = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _readAndWritePreferences();

    getPath().then((_) {
      myFile = File("$documentPath/pizzas.txt");
      writeFile();
    });
    // no need forthis if we do future builder
    // callPizzas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: FutureBuilder(
              future: callPizzas(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Pizza>?> pizzas) {
                // we can check here that snapshot status
                if (pizzas == null ||
                    pizzas.connectionState == ConnectionState.waiting ||
                    pizzas.data == null) {
                  return Text("There are no pizzas");
                }

                return ListView.builder(
                  // thisis to prev ent that error 'Vertical viewport was given unbounded height.
                  scrollDirection: Axis.vertical,
                  // this should probably be avoided - in fact, the whole screen should be scrollable
                  /* 
                  
                  Shrink wrapping the content of the scroll view is significantly more expensive than expanding to the maximum allowed size because the content can expand and contract during scrolling, which means the size of the scroll view needs to be recomputed whenever the scroll position changes
                   */
                  shrinkWrap: true,
                  itemCount: pizzas.data == null ? 0 : pizzas.data?.length,
                  itemBuilder: (BuildContext context, int position) {
                    final String title = pizzas.data?[position].pizzaName ?? "";
                    final String description =
                        pizzas.data?[position].description ?? "";

                    final String? price =
                        pizzas.data?[position].price.toString();

                    final String subtitle =
                        description + "- EUR: " + (price ?? "");
                    // final
                    return Dismissible(
                      onDismissed: (item) {
                        HttpHelper helper = HttpHelper();
                        pizzas.data!.removeWhere((element) =>
                            element.id == pizzas.data?[position].id);
                        helper.deletePizza(pizzas.data![position].id);
                      },
                      key: Key(position.toString()),
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(subtitle),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PizzaDetail(
                                      pizza: pizzas.data![position],
                                      isNew: false)));
                        },
                      ),
                    );
                  },
                );
              },
            )),
            TextField(
              controller: pwdController,
            ),
            ElevatedButton(
                onPressed: writeToSecureStorage, child: Text("Save Value")),
            ElevatedButton(
                onPressed: () {
                  readFromSecureStorage().then((value) {
                    setState(() {
                      myPass = value;
                    });
                  });
                },
                child: Text("Read Value"))

            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            // const Text("You have opened the app this many times:"),
            // Text(
            //   "$_appCounter",
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            // ElevatedButton(onPressed: _deletePreferences, child: Text("Reset")),
            // const Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Divider(
            //     thickness: 5.0,
            //     indent: 20.0,
            //     endIndent: 20.0,
            //   ),
            // ),
            // Text("Doc Path:", style: Theme.of(context).textTheme.headline4),
            // Text(documentPath),
            // Text("Temp Path:", style: Theme.of(context).textTheme.headline4),
            // Text(tempPath),
            // const Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Divider(
            //     thickness: 5.0,
            //     indent: 20.0,
            //     endIndent: 20.0,
            //   ),
            // ),
            // ElevatedButton(onPressed: readFile, child: Text("Read File")),
            // Text(fileText),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // Thi
      //s trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PizzaDetail(
              pizza: Pizza(),
              isNew: true,
            );
          }));
        },
      ),
    );
  }

  Future _readAndWritePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? appCounter = prefs.getInt("appCounter");

    if (appCounter == null) {
      appCounter = 1;
    } else {
      appCounter++;
    }

    await prefs.setInt("appCounter", appCounter);

    setState(() {
      _appCounter = appCounter!;
    });
  }

  Future _deletePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      _appCounter = 0;
    });
  }

  Future getPath() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    setState(() {
      documentPath = docDir.path;
      tempPath = tempDir.path;
    });
  }

  Future<bool> writeFile() async {
    try {
      await myFile.writeAsString("Pizza, pizza, pizza");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> readFile() async {
    try {
      String fileContent = await myFile.readAsString();
      setState(() {
        fileText = fileContent;
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String?> readFromSecureStorage() async {
    String? secret = await storage.read(key: myKey);
    return secret;
  }

  Future<List<Pizza>?> callPizzas() async {
    HttpHelper helper = HttpHelper();

    List<Pizza>? pizzas = await helper.getPizzaList();
    return pizzas;
  }
}
