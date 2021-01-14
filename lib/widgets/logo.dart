import 'package:covid_app/constant/text.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/constant/colors.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(seconds: 8),
      builder: (context, value, child) {
        return Container(
          width: 150,
          height: 150,
          child: Stack(
            children:[
              ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                    startAngle: 0.0,
                    endAngle: (3.14 * 2),
                    stops: [value, value],
                    center: Alignment.center,
                    colors: [primaryColor, Colors.transparent])
                      .createShader(rect);
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(DOT_PROGRESS)
                    ),
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:15,top: 12),
                child: Image(
                  height: 120,
                  width: 120,
                  image: AssetImage(SMALL_LOGO)
                )
              ),
            ]
          )
        );
      }
    );
  }
}