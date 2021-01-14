import 'package:auto_animated/auto_animated.dart';
import 'package:covid_app/bloc/app_bloc.dart';
import 'package:covid_app/bloc/app_events.dart';
import 'package:covid_app/bloc/app_states.dart';
import 'package:covid_app/constant/colors.dart';
import 'package:covid_app/model/notification_model.dart';
import 'package:covid_app/screens/server_failed_screen.dart';
import 'package:covid_app/widgets/logo_backgroud_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatelessWidget {

  final options = LiveOptions(
    showItemInterval: Duration(milliseconds: 100),
    showItemDuration: Duration(milliseconds: 100),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.add(FeatchNotification());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secoundaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: ()=>Navigator.pop(context),
        ),
        title: Text("Notification & Advisory"),
      ),
      body: 
      // LogoBgContainer(
        // child: 
        BlocBuilder<AppBloc,AppState>(
          cubit: appBloc,
          builder: (context,state){
            if(state is NotificationIsLoaded){
              return LiveList.options(
                options: options,
                itemCount: state.getNotificationList.length,
                itemBuilder: (context,i,animation){
                  return NotificationCardAnimation(
                    animation: animation,
                    child: NotificationCard(
                      notificationModel: state.getNotificationList[i],
                    ) 
                  );
                } 
              );
            }else if(state is IsLoading){
              return Center(
                child: CircularProgressIndicator()
              );
            }else{
              return ServerFailed();
            }
          },
        ),
      // ),
    );
  }
}

class NotificationCardAnimation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation; 
  NotificationCardAnimation({@required this.child,@required this.animation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  NotificationCard({this.notificationModel});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: primaryColor.shade50
        )
      ),
      //TODO: SMALL PDF VIEW
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.symmetric(vertical: 1,horizontal: 3),
                color: Colors.grey.shade100,
                child: Text("News",style: TextStyle(color: Colors.grey),)
              ),
              notificationModel.title!=null
                ?Text(notificationModel.title,textScaleFactor: 1.3)
                :null,
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)
                ),
                child: GestureDetector(
                  onTap: () async{
                    if(notificationModel.link!=null)
                      await launch(notificationModel.link);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.picture_as_pdf,color: Colors.amber,),
                      SizedBox(width: 5.0,),
                      notificationModel.title!=null
                        ?Expanded(
                          child: Text(notificationModel.title+".pdf",textScaleFactor: 0.7))
                        :null,
                    ],
                  ),
                )
              ),
            ],
          ),
          subtitle: notificationModel.date!=null
            ?Text(notificationModel.date)
            :null,
        ),
      ),
    );
  }
}