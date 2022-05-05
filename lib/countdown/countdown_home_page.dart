import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/countdown/countdown_bloc.dart';

class CountdownHomePage extends StatefulWidget {
  const CountdownHomePage({Key? key}) : super(key: key);

  @override
  State<CountdownHomePage> createState() => _CountdownHomePageState();
}

class _CountdownHomePageState extends State<CountdownHomePage> {
  late TimerBloc timerBloc;
  late int seconds;

  @override
  void initState() {
    timerBloc = TimerBloc();
    seconds = timerBloc.seconds;
    timerBloc.countDown();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Block"),
        ),
        body: Container(
          child: StreamBuilder(
            stream: timerBloc.secondsStream,
            initialData: seconds,
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
