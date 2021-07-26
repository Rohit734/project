import 'package:flutter/material.dart';
import './text.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  void _next() {
    setState(() {
      _index += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var words = ["Dog", "Cat", "Rat", "Elephant", "Giraffe", "Lion", "Tiger"];
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Assignment 1"),
          ),
          body: _index < words.length
              ? Change(_next, words[_index])
              : Center(child: Text("Thank you"),)),
    );
  }
}
