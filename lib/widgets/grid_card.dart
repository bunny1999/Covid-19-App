import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  String cityName,cityTemp;
  GridCard({this.cityName,this.cityTemp});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cityName,textScaleFactor: 1.3,style:TextStyle(fontWeight: FontWeight.bold)),
            Text(cityTemp+"°C",textScaleFactor: 1.1)
          ],
        ),
      ),
    );
  }
}