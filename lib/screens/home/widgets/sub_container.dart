import 'package:covid_app/constant/colors.dart';
import 'package:flutter/material.dart';

class SubContainers extends StatelessWidget {
  Widget child;
  SubContainers({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: primaryColor.shade50
          )
        ),
        child: child,
      )
    );
  }
}