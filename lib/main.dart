import 'package:covid_app/bloc/app_bloc.dart';
import 'package:covid_app/bloc/app_events.dart';
import 'package:covid_app/bloc/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid_app/constant/colors.dart';
import 'package:covid_app/screens/home/screen/home_screen.dart';
import 'package:covid_app/screens/splash_screen.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) =>AppBloc(IsLoading()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        theme: ThemeData(
          accentColor: primaryColor,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: primaryTextColor
            )
          ),
          primaryIconTheme: IconThemeData(
            color: primaryTextColor
          ),
          splashColor: primaryColor,
          brightness: Brightness.light,
        ),
        home:MultiBlocProvider(
          providers: [
            BlocProvider<AppBloc>(
              create: (context) =>AppBloc(IsLoading()),
            ),
          ],
          child: InitApp(),
        ) 
        
      ),
    );
  }
}

class InitApp extends StatefulWidget {
  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> with TickerProviderStateMixin{

  @override
  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: secoundaryColor,
      statusBarColor: secoundaryColor
    ));
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.add(FeatchStates());
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state){        
        if(state is IsLoading){
          return SplashScreen();
        }else{
          return HomeScreen();
        }
      },
    );
  }
}