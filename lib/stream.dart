import 'dart:async';
import 'package:flutter/material.dart';

class ColorStream {
  Stream? colorStream;
  Stream<Color> getColors() async* {
    final List<Color> colors = [
      Colors.blueGrey,
      Colors.amber,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.teal
    ];

    yield* Stream.periodic(Duration(seconds: 1), (int t) {
      int index = t % 5;
      return colors[index];
    });
  }
}

class NumberStream {
  StreamController<int> controller = StreamController<int>();

  addNumberToSink(int number) {
    controller.sink.add(number);
  }

  close() {
    controller.close();
  }

  addError() {
    controller.sink.addError("Error");
  }
}
