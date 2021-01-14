import 'package:covid_app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid_app/constant/colors.dart';

class ServerFailed extends StatelessWidget {
  //TODO: FIX RELOAD
  //setstate() can work for notification screen
  //for home screen it will not work
  //IF POSSIBLE FIND COMMAN SOLUTION
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<AppBloc>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Server Failed"),
          RaisedButton(
            color: secoundaryColor,
            onPressed: ()async{
              // weatherBloc.add(FeatchStates());
            },
            child: Text("Refresh")
          )
        ],
      ),
    );
  }
}