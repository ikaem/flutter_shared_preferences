import 'package:flutter/material.dart';

class PremadeTransitionsScreen extends StatefulWidget {
  const PremadeTransitionsScreen({Key? key}) : super(key: key);

  @override
  State<PremadeTransitionsScreen> createState() =>
      _PremadeTransitionsScreenState();
}

class _PremadeTransitionsScreenState extends State<PremadeTransitionsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return Scaffold(
        appBar: AppBar(title: Text("Test")),
        body: Center(
          // child: FadeTransition(
          // child: RotationTransition(
          child: ScaleTransition(
            // opacity: animation,
            // turns: animation,
            // n,
            scale: animation,
            child: Container(width: 200, height: 200, color: Colors.purple),
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
