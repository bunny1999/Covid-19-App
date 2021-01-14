import 'package:flutter/material.dart';

class StateModel{
  String name,
    ruralHospitals,
    ruralBeds,
    urbanHospitals,
    urbanBeds,
    totalHospitals,
    totalBeds,
    hospitalLastUpdate,
    helplineNumber;
  
  List<MedicalCollegesModel> medicalColleges;
  List<StateCases> stateCases;

  StateModel({
    @required this.helplineNumber,
    @required this.hospitalLastUpdate,
    @required this.medicalColleges,
    @required this.name,
    @required this.totalBeds,
    @required this.ruralBeds,
    @required this.ruralHospitals,
    @required this.totalHospitals,
    @required this.urbanBeds,
    @required this.urbanHospitals,
    @required this.stateCases
  });
}

class MedicalCollegesModel{
  String name,
    city,
    ownership,
    admissionCapacity,
    hospitalBeds;

  MedicalCollegesModel({
    @required this.admissionCapacity,
    @required this.city,
    @required this.hospitalBeds,
    @required this.name,
    @required this.ownership
  });
}

class StateCases{
  DateTime date;
  int totalConfirmed;
  StateCases({@required this.totalConfirmed,@required this.date});
}