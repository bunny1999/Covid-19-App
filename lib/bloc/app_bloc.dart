import 'package:covid_app/bloc/app_events.dart';
import 'package:covid_app/bloc/app_states.dart';
import 'package:covid_app/helper/global_model_helper.dart';
import 'package:covid_app/helper/state_model_helper.dart';
import 'package:covid_app/model/global_model.dart';
import 'package:covid_app/model/notification_model.dart';
import 'package:covid_app/model/state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent,AppState>{
  AppBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is FeatchStates){
      yield IsLoading();
      try{
        FeatchStates _featchStates=new FeatchStates();
        final confirmCaseObject= await _featchStates.getConfirmedCases();
        final sampleTestCaseObject= await _featchStates.getSampleTestCases();
        final helplineNumbersObject= await _featchStates.getHelplineNumbers();
        final medicalCollegeObject= await _featchStates.getMedicalCollegeData();
        final hospitalObject= await _featchStates.getHospitalData();
        
        List<StateModel> stateModels = await stateModelHelper(
          confirmCaseObject: confirmCaseObject, 
          helplineNumbersObject: helplineNumbersObject, 
          medicalCollegeObject: medicalCollegeObject, 
          hospitalObject: hospitalObject
        );
        
        GlobalModel globalModel = await globalModelHelper(
          confirmCaseObject: confirmCaseObject, 
          sampleTestCaseObject: sampleTestCaseObject,
          helplineNumbersObject: helplineNumbersObject, 
          hospitalObject: hospitalObject
        );

        yield StatesAreLoaded(
          stateModels: stateModels,
          globalModel: globalModel
        );
      }catch(e){
        print(e);
        yield LodingFailed();
      }
    }else if(event is FeatchNotification){
      yield IsLoading();
      try{
        List<NotificationModel> notificationList = await FeatchNotification().getNotifications();
        yield NotificationIsLoaded(notificationList: notificationList);
      }catch(e){
        print(e);
        yield LodingFailed();
      }
    }else if(event is NavigateOutWeatherScreen){
      yield IsLoading();
    }else{
      yield LodingFailed();
    }
  }
  
}