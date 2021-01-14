import 'package:covid_app/constant/colors.dart';
import 'package:flutter/material.dart';

class GraphContainer extends StatelessWidget {
  final animationFade;
  final Widget graphWidget;

  GraphContainer({@required this.graphWidget,@required this.animationFade});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationFade,
      child: Container(
        height: MediaQuery.of(context).size.height/3,
        child: Card(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: bgGraphColor,
          elevation: 0,
          margin: EdgeInsets.all(5.0),
          child: graphWidget
        ),
      ),
    );
  }
}