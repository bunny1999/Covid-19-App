
import 'package:covid_app/model/global_model.dart';
import 'package:covid_app/model/notification_model.dart';
import 'package:covid_app/model/state_model.dart';

abstract class AppState{}

class IsLoading extends AppState{} 

class StatesAreLoaded extends AppState{
  GlobalModel globalModel;
  List<StateModel> stateModels;
  StatesAreLoaded({this.globalModel,this.stateModels});

  List<StateModel> get getStateModels => stateModels;
  GlobalModel get getGlobalModel => globalModel;
}

class NotificationIsLoaded extends AppState{
  List<NotificationModel> notificationList;

  NotificationIsLoaded({this.notificationList});

  List<NotificationModel> get getNotificationList => notificationList;
}

class LodingFailed extends AppState{}