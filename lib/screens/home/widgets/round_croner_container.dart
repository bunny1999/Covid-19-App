import 'package:flutter/material.dart';

class RoundCornerContainer extends StatelessWidget {
  final color,child,borderColor;
  RoundCornerContainer({this.child,this.color,this.borderColor=Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
      child: child,
    );
  }
}