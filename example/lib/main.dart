import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String value = "";

  @override
  void initState() {
    super.initState();
    test();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> test() async {
    SharedPreferences.instance().setValue("string", "string-value");
    SharedPreferences.instance(sharedName: "shareName")
        .setValue("string", "string-value");

    SharedPreferences.instance().setValue("string", "string-value");
    SharedPreferences.instance().setValue("int", 10);
    SharedPreferences.instance().setValue("bool", true);
    SharedPreferences.instance().setValue("double", 1.01);

    String val1 = await SharedPreferences.instance().getValue("string");
    Double val2 = await SharedPreferences.instance().getValue("double");
    bool val3 = await SharedPreferences.instance().getValue("bool");
    int val4 = await SharedPreferences.instance().getValue("int");

    if (!mounted) return;

    setState(() {
      value = val1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('getValue,value=$value'),
        ),
      ),
    );
  }
}
