import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/stream.dart';

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({Key? key}) : super(key: key);

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  late int lastNumber;
  late StreamController numberStreamController;
  late NumberStream numberStream;

  // late StreamTransformer transformer;

  late StreamSubscription subscription;
  late StreamSubscription subscription2;
  String values = "";

  @override
  void initState() {
    // initialize the transformer
    // it is cool how we can type each part of the call chain
    // dynamic part is the sink
    // transformer = StreamTransformer<int, dynamic>.fromHandlers(
    //     handleData: (value, sink) {
    //       sink.add(value * 10);
    //     },
    //     handleError: (error, trace, sink) {
    //       sink.add(-1);
    //     },
    //     handleDone: (sink) => sink.close());

    colorStream = ColorStream();
    changeColor();

    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    // Stream stream = numberStreamController.stream;
    // allowing multiple subscribers to a stream, by setting it as a broadcast
    Stream stream = numberStreamController.stream.asBroadcastStream();
    lastNumber = _getRandomNumber();

    // stream.listen((event) {
    // // this is because we want to transform data
    // // stream.transform(transformer).listen((event) {
    //   print("this is event: $event");
    //   setState(() {
    //     lastNumber = event;
    //   });
    // }).onError((error) {
    //   setState(() {
    //     lastNumber = lastNumber - 1;
    //   });
    // });

    subscription = stream.listen((event) {
      setState(() {
        // lastNumber = event;
        values += event.toString() + " - ";
      });
    });

    subscription2 = stream.listen((event) {
      setState(() {
        // lastNumber = event;
        values += event.toString() + " - ";
      });
    });

    subscription.onError((error) {
      setState(() {
        lastNumber = lastNumber - 1;
      });
    });

    subscription.onDone(() {
      print("onDone was called");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stream"),
        ),
        body: Container(
          decoration: BoxDecoration(color: bgColor),
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(lastNumber.toString()),
                Text(values),
                ElevatedButton(
                    onPressed: () => addRandomNumber(),
                    child: Text("Add new random number")),
                ElevatedButton(
                    onPressed: () => stopStream(), child: Text("Stop stream"))
              ]),
        ));
  }

  void changeColor() async {
    // /* this is the most interesting part */
    // await for (Color eventColor in colorStream.getColors()) {
    //   setState(() {
    //     bgColor = eventColor;
    //   });
    // }

    // this is alternative
    colorStream.getColors().listen((event) {
      setState(() {
        // bgColor = event;
      });
    });
    // we should also close this stream somehow
  }

  int _getRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    print("this is random number: $myNum");

    return myNum;
  }

  void addRandomNumber() {
    if (numberStreamController.isClosed) {
      setState(() {
        lastNumber = lastNumber - 1;
      });

      return;
    }
    numberStream.addNumberToSink(_getRandomNumber());
    // numberStream.addError();
  }

  void stopStream() {
    numberStream.close();
  }
}
