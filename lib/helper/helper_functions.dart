import 'package:covid_app/model/global_model.dart';
import 'package:covid_app/model/state_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

DateTime dateFormater(String date){
  initializeDateFormatting();
  if(date==null) return null;
  return DateFormat("yyyy-MM-dd", 'en').parseStrict(date);
}

String nameFormater(String name){
  if(name==null) return null;
  if(name.contains('*')){
    return name.split("*")[0].trim();
  }else if(name.contains('#')){
    return name.split("#")[0].trim();
  }
  return name;
}

Future<List<StateCases>> getCasesDateRanger({
  List<StateCases> stateCases,
  DateTime startDate,
  DateTime endDate
}) async{
  List<StateCases> newList=[];
  for(StateCases stateCase in stateCases){
    if(stateCase.date.isAfter(startDate) &&
      stateCase.date.isBefore(endDate)
    ){
      newList.add(
        stateCase
      );
    }
    if(stateCase.date.compareTo(startDate)==0 ||
        stateCase.date.compareTo(endDate)==0
    ){
      newList.add(
        stateCase
      );
    }
  }

  return newList;
}

Future<List<GlobalCaseModel>> getGlobalCasesDateRanger({
  List<GlobalCaseModel> globalCases,
  DateTime startDate,
  DateTime endDate
}) async{
  List<GlobalCaseModel> newList=[];
  for(GlobalCaseModel globalCase in globalCases){
    if(globalCase.date.isAfter(startDate) &&
      globalCase.date.isBefore(endDate)
    ){
      newList.add(
        globalCase
      );
    }
    if(globalCase.date.compareTo(startDate)==0 ||
        globalCase.date.compareTo(endDate)==0
    ){
      newList.add(
        globalCase
      );
    }
  }

  return newList;
}