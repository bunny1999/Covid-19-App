
import 'package:covid_app/bloc/app_bloc.dart';
import 'package:covid_app/bloc/app_events.dart';
import 'package:covid_app/bloc/app_states.dart';
import 'package:covid_app/constant/text.dart';
import 'package:covid_app/helper/helper_functions.dart';
import 'package:covid_app/model/global_model.dart';
import 'package:covid_app/model/state_model.dart';
import 'package:covid_app/screens/home/widgets/date_picker.dart';
import 'package:covid_app/screens/home/widgets/drop_down.dart';
import 'package:covid_app/screens/home/widgets/graph_continer.dart';
import 'package:covid_app/screens/home/widgets/heading.dart';
import 'package:covid_app/screens/home/widgets/hospital_card.dart';
import 'package:covid_app/screens/home/widgets/round_croner_container.dart';
import 'package:covid_app/screens/home/widgets/sub_container.dart';
import 'package:covid_app/screens/medical_college_screen.dart';
import 'package:covid_app/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid_app/constant/colors.dart';
import 'package:covid_app/screens/server_failed_screen.dart';
import 'package:covid_app/widgets/custom_graphs.dart';
import 'package:covid_app/widgets/grid_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  AnimationController _controller;
  Animation<Offset> _animationSlideUp,_animationSlideRight;
  Animation<double> _animationFade;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animationFade = CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOutSine
    );
    
    _animationSlideUp = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _animationSlideRight = Tween<Offset>(
      begin: Offset(-1.0, .0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  ValueNotifier<StateModel> _activeStateModel=new ValueNotifier(null);
  ValueNotifier<List> _activeCaseDateRange=new ValueNotifier(null);
  DateTime _startDate =DateTime(2020,3,01),
    _endDate = DateTime.now(); 

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secoundaryColor,
        title: SlideTransition(
          position: _animationSlideRight,
          child: Row(
            children: [
              Image(
                height: 30,
                width: 30,
                image: AssetImage(SMALL_LOGO),    
              ),
              SizedBox(width: 10.0,),
              Text(APP_NAME),
            ],
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon:Icon(Icons.notifications_active),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return NotificationScreen();
                    }),
                  );
                },
              ),
              Positioned(  // draw a red marble
                top: 12.0,
                right: 14.0,
                child: new Icon(Icons.brightness_1, size: 10.0, 
                  color: Colors.redAccent),
              )
            ],
          ),
        ],  
      ),
      body: BlocBuilder<AppBloc,AppState>(
        builder: (context,state){
          if(state is StatesAreLoaded){
            _activeCaseDateRange.value=state.getGlobalModel.globalCasesModel;
            return Container(
              child:ValueListenableBuilder(
                valueListenable: _activeStateModel,
                builder:(_,StateModel _activeStateModelNotifi, __){
                  if(_activeStateModelNotifi!=null)
                    _activeCaseDateRange.value = _activeStateModelNotifi.stateCases;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        StateDropdownButton(
                          state: state,
                          value: _activeStateModelNotifi,
                          onChanged: (stateModel){
                            _activeStateModel.value=stateModel;
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: _activeCaseDateRange,
                          builder:(_,List _activeCaseDateRangeNotifi, __)=>
                            GraphContainer(
                              animationFade: _animationFade,
                              graphWidget: _activeStateModelNotifi!=null
                                ?CustomSingleLineGraph(_activeCaseDateRangeNotifi)
                                :CustomDoubleLineGraph(_activeCaseDateRangeNotifi)
                            )
                        ),
                        SizedBox(height: 8,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DatePicker(
                                  selectedDate: _startDate,
                                  onChange: (date) async{
                                    if(_activeStateModelNotifi!=null)
                                      _activeCaseDateRange.value=await getCasesDateRanger(
                                        startDate: date,
                                        endDate: _endDate,
                                        stateCases: _activeCaseDateRange.value
                                      );
                                    else{
                                      _activeCaseDateRange.value=await getGlobalCasesDateRanger(
                                        startDate: date,
                                        endDate: _endDate,
                                        globalCases: _activeCaseDateRange.value
                                      );
                                    }
                                  },
                                ),
                                RoundCornerContainer(
                                  color: bgGraphColor,
                                  child: Text("To",textScaleFactor: 1.2,),
                                ),
                                DatePicker(
                                  selectedDate: _endDate,
                                  onChange: (date) async{
                                    if(_activeStateModelNotifi!=null)
                                      _activeCaseDateRange.value=await getCasesDateRanger(
                                        startDate: _startDate,
                                        endDate: date,
                                        stateCases: _activeCaseDateRange.value
                                      );
                                    else{
                                      _activeCaseDateRange.value=await getGlobalCasesDateRanger(
                                        startDate: _startDate,
                                        endDate: date,
                                        globalCases: _activeCaseDateRange.value
                                      );
                                    }
                                  },
                                )
                              ]),
                              SizedBox(height: 10,),
                              _activeStateModelNotifi!=null
                                ?StateDeatils(
                                  stateModel: _activeStateModelNotifi,
                                )
                                :GlobalDetails(
                                  globalModel: state.getGlobalModel,
                                ),
                            ]
                          )
                        )
                      ],
                    ),
                  );
                }
              ),
            );
          }else if(state is LodingFailed){
            return ServerFailed();
          }
        },
      ),
    );
  }
}


class GlobalDetails extends StatelessWidget {
  GlobalModel globalModel;
  GlobalDetails({this.globalModel});

  @override
  Widget build(BuildContext context) {
    Future<void> _makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading("Helpline"),
          SubContainers(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                ListTile(
                  title: Text(
                    globalModel.number!=null
                      ?globalModel.number
                      :"NIll"
                  ),
                  trailing:IconButton(
                    icon: Icon(Icons.call,color: primaryColor,),
                    onPressed: () async{
                      await _makePhoneCall(globalModel.number);
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    globalModel.email!=null
                      ?globalModel.email
                      :"NIll"
                  ),
                  trailing:IconButton(
                    icon: Icon(Icons.email,color: primaryColor,),
                    onPressed: () async{
                      await _makePhoneCall(globalModel.number);
                    },
                  ),
                )
              ]
            ),
          ),
          Heading("Hospitals"),
          HospitalCard(
            ruralStr: "Rural Hospitals",
            ruralValue: globalModel.ruralHospitals,
            urbanStr: "Urban Hospitals",
            urbanValue: globalModel.urbanHospitals
          ),
          Heading("Beds"),
          HospitalCard(
            ruralStr: "Rural Beds",
            ruralValue: globalModel.ruralBeds,
            urbanStr: "Urban Beds",
            urbanValue: globalModel.urbanBeds
          ),
        ],
      ),
    );
  }
}

class StateDeatils extends StatelessWidget {
  StateModel stateModel;
  StateDeatils({this.stateModel});
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stateModel.helplineNumber!=null && stateModel.helplineNumber.length>=10
          ?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading("Helpline"),
              SubContainers(
                child: ListTile(
                  title: Text(stateModel.helplineNumber),
                  trailing: IconButton(
                    icon: Icon(Icons.call,color: primaryColor,),
                    onPressed: () async{
                      await _makePhoneCall(stateModel.helplineNumber);
                    },
                  ),
                )
              )
            ],
          )
          :null,
          Heading("Hospitals"),
          HospitalCard(
            ruralStr: "Rural Hospitals",
            ruralValue: stateModel.ruralHospitals,
            urbanStr: "Urban Hospitals",
            urbanValue: stateModel.urbanHospitals
          ),
          Heading("Beds"),
          HospitalCard(
            ruralStr: "Rural Beds",
            ruralValue: stateModel.ruralBeds,
            urbanStr: "Urban Beds",
            urbanValue: stateModel.urbanBeds
          ),
          Heading("Medical Colleges"),
          SubContainers(
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return MedicalCollegeScreen(
                      medicalCollegeModels: stateModel.medicalColleges,
                    );
                  }),
                );
              },
              leading: Text(stateModel.medicalColleges!=null
                ?stateModel.medicalColleges.length.toString():"0",textScaleFactor: 1.5,style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text("Medical Colleges",textScaleFactor: 1.0,style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.forward,color: primaryColor,),
            ),
          ),
          SizedBox(height: 10.0,)
        ],
      ),
    );
  }
}
