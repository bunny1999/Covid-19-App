
import 'package:covid_app/helper/helper_functions.dart';
import 'package:covid_app/model/state_model.dart';
import 'package:flutter/widgets.dart';

Future<List<StateModel>> stateModelHelper({
  @required final confirmCaseObject,
  @required final helplineNumbersObject,
  @required final medicalCollegeObject,
  @required final hospitalObject
}) async{
  if(confirmCaseObject==null ||
    confirmCaseObject==null ||
    helplineNumbersObject==null ||
    medicalCollegeObject==null ||
    hospitalObject==null
  ) throw Exception(["Object/Objects are not Found"]);

  Map<String,dynamic> stateDetails={};
  
  if(confirmCaseObject["data"]==null
  ) throw Exception("Confirmed Cases Deatils Not Avaliblel");

  for(final dateObjects in confirmCaseObject["data"]){
    if(dateObjects==null) continue;
    for(final object in dateObjects["regional"]){
      if(object==null) continue;
      if(stateDetails[object["loc"]]==null){
        stateDetails[object["loc"]]={};
      }
      if(stateDetails[object["loc"]]["daily"]==null){
        stateDetails[object["loc"]]["daily"]=[];
      }
      stateDetails[object["loc"]]["daily"].add({
        "date":dateObjects["day"],
        "totalConfirmed":object["totalConfirmed"]
      });
    }
  }

  if(helplineNumbersObject["data"]==null ||
    helplineNumbersObject["data"]["contacts"]==null ||
    helplineNumbersObject["data"]["contacts"]["regional"]==null
  ) throw Exception("Helpline Deatils Not Avaliblel");
  
  for(final object in helplineNumbersObject["data"]["contacts"]["regional"]){
    if(object==null) continue;
    if(stateDetails[object["loc"]]!=null){
      stateDetails[object["loc"]]["number"]=object["number"];
    }
  }

  if(hospitalObject["data"]==null ||
    hospitalObject["data"]["regional"]==null
  ) throw Exception("Hospital Deatils Not Avaliblel");

  for(final object in hospitalObject["data"]["regional"]){
    if(object==null) continue;
    if(stateDetails[object["state"]]==null){
      continue;
    }
    stateDetails[object["state"]]["ruralHospitals"]=object["ruralHospitals"];   
    stateDetails[object["state"]]["ruralBeds"]=object["ruralBeds"];   
    stateDetails[object["state"]]["urbanHospitals"]=object["urbanHospitals"];   
    stateDetails[object["state"]]["urbanBeds"]=object["urbanBeds"];   
    stateDetails[object["state"]]["totalHospitals"]=object["totalHospitals"];   
    stateDetails[object["state"]]["totalBeds"]=object["totalBeds"];   
    stateDetails[object["state"]]["asOn"]=object["asOn"];   
  }

  if(medicalCollegeObject["data"]==null ||
    medicalCollegeObject["data"]["medicalColleges"]==null
  ) throw Exception("Medical College Deatils Not Avaliblel");
  
  for(final object in medicalCollegeObject["data"]["medicalColleges"]){
    if(object==null) continue;
    if(stateDetails[object["state"]]==null){
      continue;
    }
    if(stateDetails[object["state"]]["medicalCollege"]==null){
      stateDetails[object["state"]]["medicalCollege"]=[];
    }
    stateDetails[object["state"]]["medicalCollege"].add({
      "name":object["name"],
      "city":object["city"],
      "ownership":object["ownership"],   
      "admissionCapacity":object["admissionCapacity"],   
      "hospitalBeds":object["hospitalBeds"]
    });
  }
  
  List<StateModel> stateModels=[];

  stateDetails.forEach((key, value) {
    List<MedicalCollegesModel> medicalCollegeModels=[];
    List<StateCases> stateCasesModels=[];
    if(value["medicalCollege"]!=null)
      for(final object in value["medicalCollege"]){
        medicalCollegeModels.add(
          MedicalCollegesModel(
            admissionCapacity: object["admissionCapacity"]!=null
              ?object["admissionCapacity"].toString()
              :"", 
            city: object["city"]!=null
              ?object["city"]
              :"", 
            hospitalBeds: object["hospitalBeds"]!=null
              ?object["hospitalBeds"].toString()
              :"",
            name: object["name"]!=null
              ?object["name"]
              :"", 
            ownership: object["ownership"]!=null
              ?object["ownership"]
              :"",
          )
        );
      }
    if(value["daily"]!=null)
      for(final object in value["daily"]){
        stateCasesModels.add(
          StateCases(
            date:object["date"]!=null
              ?dateFormater(object["date"])
              :null,
            totalConfirmed: object["totalConfirmed"]!=null
              ?object["totalConfirmed"]
              :0,
          )
        );
      }
    stateModels.add(
      StateModel(
        helplineNumber: value["number"]!=null
          ?value["number"]
          :"", 
        //TODO:
        hospitalLastUpdate: value["asOn"]!=null
          ?value["asOn"].toString()
          :"",  
        name: nameFormater(key), 
        totalBeds: value["totalBeds"]!=null
          ?value["totalBeds"].toString()
          :"",  
        ruralBeds: value["ruralBeds"]!=null
          ?value["ruralBeds"].toString()
          :"",  
        ruralHospitals: value["ruralHospitals"]!=null
          ?value["ruralHospitals"].toString()
          :"",  
        totalHospitals: value["totalHospitals"]!=null
          ?value["totalHospitals"].toString()
          :"",  
        urbanBeds: value["urbanBeds"]!=null
          ?value["urbanBeds"].toString()
          :"",  
        urbanHospitals: value["urbanHospitals"]!=null
          ?value["urbanHospitals"].toString()
          :"", 
        medicalColleges: medicalCollegeModels, 
        stateCases: stateCasesModels
      )
    );
  });
  return stateModels;
}