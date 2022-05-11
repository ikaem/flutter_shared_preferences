import 'package:flutter/material.dart';

class AnimationsHomeScreen extends StatefulWidget {
  const AnimationsHomeScreen({Key? key}) : super(key: key);

  @override
  State<AnimationsHomeScreen> createState() => _AnimationsHomeScreenState();
}

class _AnimationsHomeScreenState extends State<AnimationsHomeScreen> {
  int iteration = 0;
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.orange,
  ];
  final List<double> sizes = [100, 125, 150, 175, 200];
  final List<double> tops = [0, 50, 100, 150, 200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Animations"), actions: <Widget>[
          IconButton(
              onPressed: () {
                // what are we incrementing here
                // also, note that we are just doing statement, we dont assing directly value, but through teritary
                // iteration < colors.length - 1 ? iteration++ : iteration = 0;
                setState(() {
                  // we do reassign it to itself, even with the same value too
                  // so we dont need to reassing it
                  iteration < colors.length - 1 ? iteration++ : iteration = 0;

                  // iteration = iteration;
                });
              },
              icon: Icon(Icons.run_circle))
        ]),
        body: Center(
          child: AnimatedContainer(
              width: sizes[iteration],
              height: sizes[iteration],
              margin: EdgeInsets.only(top: tops[iteration]),
              duration: Duration(seconds: 1),
              color: colors[iteration]),
        ));
  }
}
