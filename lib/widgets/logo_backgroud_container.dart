import 'package:covid_app/constant/text.dart';
import 'package:flutter/material.dart';

class LogoBgContainer extends StatelessWidget {
  Widget child;
  LogoBgContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(BIG_LOGO)
        )
      ),
      child: child,
    );
  }
}