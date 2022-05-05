import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/stream_home_page.dart';

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
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: StreamHomePage(
          // i dont know if this is how keys should be created
          key: Key("Home page"),
        ));
  }
}
