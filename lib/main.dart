import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/animated_list/animated_list_screen.dart';
import 'package:flutter_shared_preferences/animations/animations_home_screen.dart';
import 'package:flutter_shared_preferences/animations/list_screen.dart';
import 'package:flutter_shared_preferences/animations/shape_animation.dart';
import 'package:flutter_shared_preferences/countdown/countdown_home_page.dart';
import 'package:flutter_shared_preferences/creating_packages/package_home_screen.dart';
import 'package:flutter_shared_preferences/dismissable/dimissible_screen.dart';
import 'package:flutter_shared_preferences/google_map/google_map_home_screen.dart';
import 'package:flutter_shared_preferences/premade-transitions/premade_transitions_screen.dart';
import 'package:flutter_shared_preferences/stream-builder/stream_home_page.dart';
// import 'package:flutter_shared_preferences/stream_home_page.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: StreamHomePage(
        //   // i dont know if this is how keys should be created
        //   key: Key("Home page"),
        // )

        // home: CountdownHomePage())
        // home: PackageHomeScreen()
        // home: GoogleMapHomeScreen()
        // home: AnimationsHomeScreen()
        // home: ShapeAnimation()
        // home: ListScreen(),
        // home: PremadeTransitionsScreen()
        // home: AnimatedListScreen()
        home: DismissibleScreen());
  }
}
