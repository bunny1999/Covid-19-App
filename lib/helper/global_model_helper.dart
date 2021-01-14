
import 'package:covid_app/helper/helper_functions.dart';
import 'package:covid_app/model/global_model.dart';
import 'package:flutter/material.dart';

Future<GlobalModel> globalModelHelper({
  @required final confirmCaseObject,
  @required final sampleTestCaseObject,
  @required final helplineNumbersObject,
  @required final hospitalObject
}) async{
  if(confirmCaseObject==null ||
    confirmCaseObject==null ||
    helplineNumbersObject==null ||
    hospitalObject==null
  ) throw Exception(["Object/Objects are not Found"]);

  Map<String,dynamic> main={};
  if(helplineNumbersObject["data"]==null ||
    helplineNumbersObject["data"]["contacts"]==null ||
    helplineNumbersObject["data"]["contacts"]["primary"]==null
  ) throw Exception("Helpline Deatils Not Avaliblel");

  if(hospitalObject["data"]==null ||
    hospitalObject["data"]["summary"]==null
  ) throw Exception("Hospital Deatils Not Avaliblel");

  if(confirmCaseObject["data"]==null
  ) throw Exception("Confirmed Cases Deatils Not Avaliblel");

  for(final dateObjects in confirmCaseObject["data"]){
    if(dateObjects==null) continue;
    if(main[dateObjects["day"]]==null){
      main[dateObjects["day"]]={};
    }
    main[dateObjects["day"]]["total"]=dateObjects["summary"]["total"];
  }

  if(sampleTestCaseObject["data"]==null
  ) throw Exception("Sample Test Cases Deatils Not Avaliblel");

  for(final dateObjects in sampleTestCaseObject["data"]){
    if(dateObjects==null) continue;
    if(main[dateObjects["day"]]==null){
      continue;
    }
    main[dateObjects["day"]]["totalSamplesTested"]=dateObjects["totalSamplesTested"];
  } 

  List<GlobalCaseModel> globalCaseModels=[];
  main.forEach((key, value){
    globalCaseModels.add(
      GlobalCaseModel(
        date: dateFormater(key), 
        confirmedCases: value["total"], 
        sampleTestCases: value["totalSamplesTested"]
      )
    );
  });
  
  return GlobalModel(

    globalCasesModel: globalCaseModels, 
    email: main["email"]=helplineNumbersObject["data"]["contacts"]["primary"]["email"]!=null
      ?main["email"]=helplineNumbersObject["data"]["contacts"]["primary"]["email"].toString()
      :"",  
    number: helplineNumbersObject["data"]["contacts"]["primary"]["number"]!=null
      ?helplineNumbersObject["data"]["contacts"]["primary"]["number"].toString()
      :"", 
    ruralBeds: hospitalObject["data"]["summary"]["ruralBeds"]!=null
      ?hospitalObject["data"]["summary"]["ruralBeds"].toString()
      :"",  
    ruralHospitals:  hospitalObject["data"]["summary"]["ruralHospitals"]!=null
      ?hospitalObject["data"]["summary"]["ruralHospitals"].toString()
      :"",  
    totalBeds:hospitalObject["data"]["summary"]["totalBeds"]!=null
      ?hospitalObject["data"]["summary"]["totalBeds"].toString()
      :"",  
    totalHospitals: hospitalObject["data"]["summary"]["totalHospitals"]!=null
      ?hospitalObject["data"]["summary"]["totalHospitals"].toString()
      :"",  
    urbanBeds:hospitalObject["data"]["summary"]["urbanBeds"]!=null
      ?hospitalObject["data"]["summary"]["urbanBeds"].toString()
      :"",  
    urbanHospitals:hospitalObject["data"]["summary"]["urbanHospitals"]!=null
      ?hospitalObject["data"]["summary"]["urbanHospitals"].toString()
      :"", 
  );
}