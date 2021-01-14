import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  String text;
  Heading(text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,textScaleFactor: 1.1,style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}