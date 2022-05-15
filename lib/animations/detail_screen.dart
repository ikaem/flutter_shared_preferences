import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int index;

  const DetailScreen(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Screen"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Hero(
                    tag: "cup$index",
                    child: Icon(Icons.free_breakfast, size: 96),
                  ),
                )),
            Expanded(child: Container(), flex: 3),
          ],
        ));
  }
}
