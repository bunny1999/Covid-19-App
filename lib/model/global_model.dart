import 'package:flutter/material.dart';

class GlobalModel{
  String number,
    email,
    ruralHospitals,
    ruralBeds,
    urbanHospitals,
    urbanBeds,
    totalHospitals,
    totalBeds;

  List<GlobalCaseModel> globalCasesModel;

  GlobalModel({
    @required this.email,
    @required this.globalCasesModel,
    @required this.number,
    @required this.ruralBeds,
    @required this.ruralHospitals,
    @required this.totalBeds,
    @required this.totalHospitals,
    @required this.urbanBeds,
    @required this.urbanHospitals,
  });
}

class GlobalCaseModel{
  DateTime date;
  int confirmedCases,
    sampleTestCases;

  GlobalCaseModel({
    @required this.date,
    @required this.confirmedCases,
    @required this.sampleTestCases,
  });
}

