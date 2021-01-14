import 'package:auto_animated/auto_animated.dart';
import 'package:covid_app/constant/colors.dart';
import 'package:covid_app/model/state_model.dart';
import 'package:covid_app/screens/home/widgets/hospital_card.dart';
import 'package:flutter/material.dart';
class MedicalCollegeScreen extends StatelessWidget {
  List<MedicalCollegesModel> medicalCollegeModels;
  MedicalCollegeScreen({this.medicalCollegeModels});

  final options = LiveOptions(
    showItemInterval: Duration(milliseconds: 100),
    showItemDuration: Duration(milliseconds: 100),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secoundaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: ()=>Navigator.pop(context),
        ),
        title: Text("Medical Colleges"),
      ),
      body:LiveList.options(
        options: options,
        itemCount: medicalCollegeModels.length,
        itemBuilder: (context,i,animation){
          return MedicalCollegeCardAnimation(
            animation: animation,
            child: MedicalCollegeCard(
              medicalCollegeModel: medicalCollegeModels[i],
            ) 
          );
        } 
      )
    );
  }
}

class MedicalCollegeCard extends StatelessWidget {
  final MedicalCollegesModel medicalCollegeModel;
  MedicalCollegeCard({this.medicalCollegeModel});
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              medicalCollegeModel.ownership!=null?Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.symmetric(vertical: 1,horizontal: 3),
                color: primaryColorLite,
                child: Text(medicalCollegeModel.ownership,style: TextStyle(color: Colors.white),)
              ):null,
              medicalCollegeModel.name!=null
                ?Text(medicalCollegeModel.name,textScaleFactor: 1.3)
                :null,
              HospitalCard(
                ruralStr: "Admis. Capacity",
                ruralValue: medicalCollegeModel.admissionCapacity,
                urbanStr: "Hospital Beds",
                urbanValue: medicalCollegeModel.hospitalBeds,
              )
            ],
          ),
          subtitle: medicalCollegeModel.city!=null
            ?Text("City: "+medicalCollegeModel.city)
            :null,
        ),
      ),
    );
  }
}

class MedicalCollegeCardAnimation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation; 
  MedicalCollegeCardAnimation({@required this.child,@required this.animation});

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