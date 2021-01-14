import 'package:covid_app/constant/colors.dart';
import 'package:covid_app/screens/home/widgets/round_croner_container.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  DateTime selectedDate;
  Function onChange;
  DatePicker({this.onChange,this.selectedDate});
  @override
  _DatePickerState createState() => _DatePickerState(selectedDate: selectedDate);
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate;
  
  _DatePickerState({this.selectedDate});

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 03),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: primaryColor,
                primaryColorDark: primaryColor,
                accentColor: primaryColor,
              ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child,
        );
      }
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        DateTime date= await _selectDate(context);
        widget.onChange(date);
      },
      child: RoundCornerContainer(
        borderColor: bgGraphColor,
        color: primaryColorLite,
        child:Text("$selectedDate".split(' ')[0],textScaleFactor: 1.2,style: TextStyle(color: Colors.white),)
      )
    );
  }
}