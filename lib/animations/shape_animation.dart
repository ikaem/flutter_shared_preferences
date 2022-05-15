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

  // this is old
  late Animation<double> animation;
  // double pos = 0;

  double maxLeft = 0;
  double maxTop = 0;
  double posLeft = 0;
  double posTop = 0;
  final int ballSize = 100;
  // late Animation<double> animationLeft;
  // late Animation<double> animationTop;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          // this is for optimizing animatiosn recipe
          // ..repeat();
          ..repeat(reverse: true);
    // animation = Tween<double>(begin: 0, end: 200).animate(controller)
    //   ..addListener(() {
    //     print("hello");
    //     moveBall();
    //   });

    // animationLeft = Tween<double>(begin: 0, end: 200).animate(controller);
    // animationTop =
    //     // we use cascade to call listener on the animation top, not on the animate method's return
    //     Tween<double>(begin: 0, end: 400).animate(controller)
    //       ..addListener(moveBall);

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      moveBall();
    });

    // controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("PosLeft: $posLeft");

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
        // body: Stack(
        //   children: <Widget>[
        //     // so positioned needs to work with stack
        //     Positioned(
        //       child: Ball(),
        //       left: posLeft,
        //       top: posTop,
        //     )
        //   ],
        // )

        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              maxLeft = constraints.maxWidth - ballSize;
              maxTop = constraints.maxHeight - ballSize;
              // return Stack(
              //   children: <Widget>[
              //     // so positioned needs to work with stack
              //     Positioned(
              //       child: Ball(),
              //       left: posLeft,
              //       top: posTop,
              //     )
              //   ],
              // );

              return Stack(
                children: <Widget>[
                  AnimatedBuilder(
                    animation: controller,
                    child:
                        Positioned(left: posLeft, top: posTop, child: Ball()),
                    // builder: (BuildContext context, Widget child) {
                    //   moveBall();
                    //   return Positioned(
                    //       left: posLeft, top: posTop, child: Ball());
                    // }
                    builder: (BuildContext context, Widget? child) {
                      return Positioned(
                          left: posLeft, top: posTop, child: Ball());
                    },
                  )

                  // so positioned needs to work with stack
                  // Positioned(
                  //   child: Ball(),
                  //   left: posLeft,
                  //   top: posTop,
                  // )
                ],
              );
            },
          ),
        ));
  }

  void moveBall() {
    // setState(() {
    //   // pos = animation.value;
    //   // posLeft = animationLeft.value;
    //   // posTop = animationTop.value;

    //   posLeft = animation.value * maxLeft;
    //   posTop = animation.value * maxTop;
    // });

    posLeft = animation.value * maxLeft;
    posTop = animation.value * maxTop;
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
