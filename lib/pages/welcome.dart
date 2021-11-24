import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/pages/body.dart';

class Welcome extends StatefulWidget {


  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int dayCount = 0;
  String body = "Haki";

  Future<int> getDayCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(base.daycount) ?? 0;
  }

  Future<String> getBody() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(base.body) ?? "";
  }

  Widget _teks(){
    if (dayCount<=7){
      return Text(
          'Day ${dayCount} of $body Workout',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: base.fontColor,
              fontSize: 40,
              fontWeight: FontWeight.bold
          )
      );
    } else {
      return Text(
          'Please create new workout',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getDayCount().then((n){
      dayCount = n;
      setState(() {});
    });
    getBody().then((m){
      body = m;
      setState(() {});
    });
  }

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
                          10,
                          MediaQuery.of(context).size.height / 5,
                          10,
                          MediaQuery.of(context).size.height / 40),
                      child: Text(
                          "Welcome",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: base.fontColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical:80.0)
                    ),
                    Text(
                        'Are you ready to start your workout today?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                        )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical:10.0)
                    ),

                    // I'm Ready
                    ElevatedButton(
                      onPressed: () async {
                        dayCount++;
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setInt(base.daycount, dayCount);
                        setState(() {
                          dayCount = pref.getInt(base.daycount) ?? 0;
                        });
                        print('nambah 1 hari');
                      },
                      child: Text("I'm Ready"),
                      style: ElevatedButton.styleFrom(
                        primary: base.frontColor,
                        fixedSize: Size(MediaQuery.of(context).size.height*0.9, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                  ]
                ),
              ),
        ),
    );
  }
}
