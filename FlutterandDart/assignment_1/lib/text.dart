import 'package:flutter/material.dart';
import './textButton.dart';

class Change extends StatelessWidget {
  final VoidCallback nextWord;
  final String words;
  Change(this.nextWord, this.words);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          words,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.cyan[900]),
        ),
        ChangeButton(nextWord),
      ],
    ));
  }
}
