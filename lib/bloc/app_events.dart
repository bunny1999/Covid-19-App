import 'dart:convert';

import 'package:covid_app/helper/notification_model_helper.dart';
import 'package:covid_app/model/notification_model.dart';
import 'package:covid_app/constant/text.dart';
import 'package:http/http.dart' as http;

abstract class AppEvent {}

class FeatchStates extends AppEvent {
  Future getConfirmedCases() async{
    final result = await http.Client().get(API_CONFIRMED_CASE);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed Confirmed Cases:${result.statusCode}"]);
    
    return json.decode(result.body);
  }
  Future getSampleTestCases() async{
    final result = await http.Client().get(API_SAMPLE_TESTED_DAY);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed Sample Test Cases:${result.statusCode}"]);
    
    return json.decode(result.body);
  }
  Future getHelplineNumbers() async{
    final result = await http.Client().get(API_HELPLINE_NO);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed Helpline Numbers:${result.statusCode}"]);
    
    return json.decode(result.body);
  }
  Future getHospitalData() async{
    final result = await http.Client().get(API_HOSPITAL_BEDS);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed Hospital Data:${result.statusCode}"]);
    
    return json.decode(result.body);
  }
  Future getMedicalCollegeData() async{
    final result = await http.Client().get(API_MEDICAL_COLLAGE_BEDS);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed Medical College Data:${result.statusCode}"]);
    
    return json.decode(result.body);
  }
}

class FeatchNotification extends AppEvent{
  Future<List<NotificationModel>> getNotifications() async{
    final result = await http.Client().get(API_NOTIFICATION);
    
    if(result.statusCode != 200)
      throw Exception(["Request Failed:${result.statusCode}"]);

    return notificationModelHelper(result.body);
  }
}

class NavigateOutWeatherScreen extends AppEvent{}