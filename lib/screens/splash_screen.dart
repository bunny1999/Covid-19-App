import 'package:covid_app/constant/text.dart';
import 'package:covid_app/widgets/logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomLogo(),                   
            SizedBox(height: 20,),
            Text(APP_NAME,textScaleFactor: 1.8,style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
