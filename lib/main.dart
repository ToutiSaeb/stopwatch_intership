import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stopwatch/view/stopwatch_home.dart';
void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Professional Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.purple, 
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StopwatchHome(),
    );
  }
}
