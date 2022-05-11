import 'package:flutter/material.dart';

class ShapeAnimation extends StatefulWidget {
  const ShapeAnimation({Key? key}) : super(key: key);

  @override
  State<ShapeAnimation> createState() => _ShapeAnimationState();
}

class _ShapeAnimationState extends State<ShapeAnimation>
    // with TickerProviderStateMixin {
    with
        SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double pos = 0;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween<double>(begin: 0, end: 200).animate(controller)
      ..addListener(() {
        print("hello");
        moveBall();
      });

    // controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animation Contorller"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  controller.reset();
                  controller.forward();
                },
                icon: Icon(Icons.run_circle))
          ],
        ),
        body: Stack(
          children: <Widget>[
            // so positioned needs to work with stack
            Positioned(
              child: Ball(),
              left: pos,
              top: pos,
            )
          ],
        ));
  }

  void moveBall() {
    setState(() {
      pos = animation.value;
    });
  }
}

class Ball extends StatelessWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      // note how easy it is to create a circle
      decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
    );
  }
}
