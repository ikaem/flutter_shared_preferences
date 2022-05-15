import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class DismissibleScreen extends StatefulWidget {
  const DismissibleScreen({Key? key}) : super(key: key);

  @override
  State<DismissibleScreen> createState() => _DismissibleScreenState();
}

class _DismissibleScreenState extends State<DismissibleScreen> {
  final List<String> sweets = [
    'Petit Four',
    'Cupcake',
    'Donut',
    'Éclair',
    'Froyo',
    'Gingerbread ',
    'Honeycomb ',
    'Ice Cream Sandwich',
    'Jelly Bean',
    'KitKat'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dismissible Example"),
      ),
      body: ListView.builder(
        itemCount: sweets.length,
        itemBuilder: (BuildContext context, int index) {
          return OpenContainer(
            transitionDuration: Duration(milliseconds: 200),
            transitionType: ContainerTransitionType.fade,
            closedBuilder: (BuildContext context, openContainer) {
              return Dismissible(
                key: Key(sweets[index]),
                child: ListTile(
                  title: Text(sweets[index]),
                  onTap: () {
                    openContainer();
                  },
                ),
                onDismissed: (DismissDirection direction) {
                  print("This is direction: $direction");
                  sweets.removeAt(index);
                },
              );
            },
            openBuilder: (BuildContext context, closeContainer) {
              return Scaffold(
                appBar:
                    AppBar(title: Text("This is opened for ${sweets[index]}")),
                body: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.cake,
                          size: 200,
                          color: Colors.orange,
                        ),
                      ),
                      Text(sweets[index]),
                    ],
                  ),
                ),
              );
            },
          );

          // return Dismissible(
          //   key: Key(sweets[index]),
          //   child: ListTile(title: Text(sweets[index])),
          //   onDismissed: (DismissDirection direction) {
          //     print("This is direction: $direction");
          //     sweets.removeAt(index);
          //   },
          // );
        },
      ),
    );
  }
}
