import 'package:flutter/material.dart';
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
  int _counter = 0;
  int _appCounter = 0;
  String documentPath = "";
  String tempPath = "";
  late File myFile;
  String fileText = "";

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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text("You have opened the app this many times:"),
            Text(
              "$_appCounter",
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(onPressed: _deletePreferences, child: Text("Reset")),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                thickness: 5.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
            ),
            Text("Doc Path:", style: Theme.of(context).textTheme.headline4),
            Text(documentPath),
            Text("Temp Path:", style: Theme.of(context).textTheme.headline4),
            Text(tempPath),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                thickness: 5.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
            ),
            ElevatedButton(onPressed: readFile, child: Text("Read File")),
            Text(fileText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
}
