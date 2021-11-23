import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/pages/body.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: base.backColor,
          child: Column(
            children: [
              Padding(
              padding: EdgeInsets.fromLTRB(
                5,
                MediaQuery.of(context).size.height *0.45,
                5,
                MediaQuery.of(context).size.height / 40),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: base.fontColor, width: 2.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: base.frontColor, width: 2.5),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: base.fontColor)
                  ),

                ),


              ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: base.fontColor, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: base.frontColor, width: 2.5),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: base.fontColor)
                ),

              ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height / 40,
                MediaQuery.of(context).size.height / 40,
                MediaQuery.of(context).size.height / 40,
                0),
            child: ElevatedButton(
              onPressed: () {
                print('hihi');
              },
              child: Text("Login", style: TextStyle(color: base.fontColor)),
              style: ElevatedButton.styleFrom(
                primary: base.frontColor,
                fixedSize: Size(MediaQuery.of(context).size.height*0.9, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: base.frontColor)
                ),
              ),
            ),
          ),
          ]
      )

        )
      )
    );
  }
}
