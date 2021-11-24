import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/pages/body.dart';
import 'package:flutter_dss/pages/gender.dart';
import 'package:flutter_dss/pages/mood.dart';
import 'package:flutter_dss/workout_api.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int dayCount = 0;
  String body = "Haki";
  WorkoutAPI woapi = new WorkoutAPI();

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
              color: Colors.white,
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
                    0,
                    MediaQuery.of(context).size.height / 5,
                    0,
                    MediaQuery.of(context).size.height / 40),
                child: _teks(),
              ),
              Text(
                  'Are you ready to start your workout today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),

              // I'm Ready
              Visibility(
                visible: (dayCount<=7),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.height / 40,
                      MediaQuery.of(context).size.height / 40,
                      MediaQuery.of(context).size.height / 40,
                      0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                              return Mood();
                            })
                        );
                        // dayCount++;
                        // SharedPreferences pref = await SharedPreferences.getInstance();
                        // pref.setInt(base.daycount, dayCount);
                        // setState(() {
                        //   dayCount = pref.getInt(base.daycount) ?? 0;
                        // });
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
                ),
              ),

              // change info
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 40,
                    0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                          return Gender();
                        })
                    );
                    // setState(() {
                    //   dayCount = pref.getInt(base.daycount) ?? 0;
                    // });
                    print('masuk ke change info');
                  },
                    child: Text("Change Info", style: TextStyle(color: base.frontColor)),
                  style: ElevatedButton.styleFrom(
                    primary: base.backColor,
                    fixedSize: Size(MediaQuery.of(context).size.height*0.9, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: base.frontColor)
                    ),
                  ),
                ),
              ),

              // New Workout
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 40,
                    0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                            return Body();
                          })
                      );
                      // setState(() {
                      //   dayCount = pref.getInt(base.daycount) ?? 0;
                      // });
                      print('workout jadi 1');
                    },
                    child: Text("New Workout", style: TextStyle(color: base.frontColor)),
                  style: ElevatedButton.styleFrom(
                    primary: base.backColor,
                    fixedSize: Size(MediaQuery.of(context).size.height*0.9, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: base.frontColor)
                    ),
                  ),
                ),
              ),

              // History
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 40,
                    MediaQuery.of(context).size.height / 40,
                    0),
                // child: ElevatedButton(
                //     onPressed: () {
                //       woapi.login('yanyan@gmail.com','hehehe');
                //     },
                //     child: Text("History", style: TextStyle(color: base.frontColor)),
                //     style: ElevatedButton.styleFrom(
                //       primary: base.backColor,
                //       fixedSize: Size(screenWidth, 40),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20),
                //         side: BorderSide(color: base.frontColor)
                //       ),
                //     ),
                // ),
              ),
            ],
          )
        )
      )
    );
  }
}
