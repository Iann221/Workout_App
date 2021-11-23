import 'package:flutter/material.dart';
import 'package:flutter_dss/pages/home.dart';
import 'package:flutter_dss/pages/gender.dart';
import 'package:flutter_dss/pages/login.dart';
import 'package:flutter_dss/pages/history.dart';
import 'package:flutter_dss/pages/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSS gan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NunitoSans'
      ),
      home: History(),
    );
  }
}
