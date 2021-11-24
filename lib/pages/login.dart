import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/pages/body.dart';
import 'package:flutter_dss/workout_model.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        body: SafeArea(
            child: Container(
                color: base.backColor,
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                5,
                                screenHeight *0.1,
                                5,
                                screenHeight / 40),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
                            child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: usernameController,
                                decoration: InputDecoration(
                                    fillColor: base.fontColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: base.fontColor, width: 2.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: base.frontColor, width: 2.5),
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: base.fontColor.withOpacity(0.4)))
                            ),

                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: passwordController,
                              obscureText: true,
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
                                  hintStyle: TextStyle(color: base.fontColor.withOpacity(0.4))
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
                                //fungsi get dan post
                                print(usernameController);
                                print(passwordController);
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
                    ),
                  ),
                )

            )
        )
    );
  }
}