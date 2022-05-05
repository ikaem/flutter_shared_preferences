import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/stream-builder/stream.dart';

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({Key? key}) : super(key: key);

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  late Stream<int> numberStream;

  @override
  void initState() {
    numberStream = NumberStream().getNumbers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Stream")),
        body: Container(
          child: StreamBuilder(
            stream: numberStream,
            initialData: 0,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("Error");
              }

              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data.toString(),
                    style: TextStyle(fontSize: 96),
                  ),
                );
              } else {
                return Center();
              }
            },
          ),
        ));
  }
}
