import 'package:flutter/material.dart';
import 'package:covid_app/constant/colors.dart';

class MyTextField extends StatelessWidget {
  
  OutlineInputBorder MyEnableBoder()=>OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: BorderSide(
      color: primaryColorLite,
      width: 2.0,
    ),
  );

  OutlineInputBorder MyDisableBoder()=>OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: BorderSide(
      color: primaryColor,
      width: 3.0
    ),
  );
  bool obsureText;
  Function onChanged;
  String errorMessgae,hintText;

  MyTextField({@required this.errorMessgae,@required this.hintText,this.obsureText=false,@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsureText,
      onChanged:(value)=> onChanged(value),
      validator: (value) {
        if (value.isEmpty) {
          return errorMessgae;
        }
        return null;
      },
      autofocus: false,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColorLite),
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: MyDisableBoder(),
        enabledBorder: MyEnableBoder(),
        border: MyEnableBoder()
      ),
    );
  }
}