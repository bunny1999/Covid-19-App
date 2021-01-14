import 'dart:convert';

import 'package:covid_app/model/notification_model.dart';

List<NotificationModel> notificationModelHelper(final responce){
  var object = jsonDecode(responce);
  if(object==null ||
    object["data"]==null ||
    object["data"]["notifications"]==null)
    throw Exception(["Notification Object NULL"]);

  List<dynamic> notifi = object["data"]["notifications"];
  List<NotificationModel> notificationList = [];

  for(dynamic notification in notifi){
    if(notification==null)
      continue;

    String _title=notification["title"]!=null
      ?notification["title"]
      :null;
    String _date;
    if(_title!=null){
      _title=_title.trim();
      if(_title.contains(new RegExp(r'&nbsp;', caseSensitive: false))){
        _title=_title.split(new RegExp(r'&nbsp;', caseSensitive: false))[1].trim();
      }else if(_title.contains(new RegExp(r'(2020|2021)'))){
        int _index=_title.indexOf(new RegExp(r'(2020|2021)'));
        _date=_title.substring(0,_index+4).trim();
        _title=_title.substring(_index+4).trim();
      }
    }

    notificationList.add(
      NotificationModel(
        date: _date,
        title: _title,
        link: notification["link"]!=null
          ?notification["link"]
          :null
      )
    );
  }
  return notificationList; 
}