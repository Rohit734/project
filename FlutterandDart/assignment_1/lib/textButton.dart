import 'package:flutter/material.dart';

class ChangeButton extends StatelessWidget {
  final VoidCallback nextWord;

  ChangeButton(this.nextWord);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: nextWord,
      child: Text("Next"),
    );
  }
}
