import 'package:covid_app/constant/colors.dart';
import 'package:covid_app/screens/home/widgets/sub_container.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  String ruralStr,ruralValue,urbanStr,urbanValue;
  HospitalCard({this.ruralStr,this.ruralValue,this.urbanStr,this.urbanValue});
  @override
  Widget build(BuildContext context) {
    return SubContainers(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(ruralStr,textScaleFactor: 1.3,style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
                  MyDiveder(
                    height: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(ruralValue!=null?ruralValue:"Nill",textScaleFactor: 1.3,),
                  ),
                ],
              ),
            ),
          ),
          MyDiveder(
            width: 2.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(urbanStr,textScaleFactor: 1.3,style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
                  MyDiveder(
                    height: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(urbanValue!=null?urbanValue:"Nill",textScaleFactor: 1.3,),
                  ),
                ],
              ),
            ),
          )
        ]
      )
    );
  }
}

class MyDiveder extends StatelessWidget {
  final width,height;
  MyDiveder({this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: bgGraphColor,
    );
  }
}