import 'package:area/area.dart';
import 'package:flutter/material.dart';
// import "package:area/area.dart";

class PackageHomeScreen extends StatefulWidget {
  const PackageHomeScreen({Key? key}) : super(key: key);

  @override
  State<PackageHomeScreen> createState() => _PackageHomeScreenState();
}

class _PackageHomeScreenState extends State<PackageHomeScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWidth = TextEditingController();

  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Package App"),
        ),
        body: Column(
          children: <Widget>[
            AppTextField(controller: txtWidth, label: "Width"),
            AppTextField(controller: txtHeight, label: "Height"),
            Padding(
              padding: EdgeInsets.all(24),
            ),
            ElevatedButton(
                onPressed: () {
                  double width = double.tryParse(txtWidth.text) ?? 0;
                  double height = double.tryParse(txtHeight.text) ?? 0;

                  String res = calculateAreaRect(width, height);

                  setState(() {
                    result = res;
                  });
                },
                child: Text("Calculate Area")),
            Padding(padding: EdgeInsets.all(24)),
            Text(result)
          ],
        ));
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const AppTextField({Key? key, required this.controller, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(24),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: label),
        ));
  }
}
