import 'package:flutter/material.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/pages/home.dart';
import 'package:flutter_dss/workout_api.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selected = "ass";
  double screenWidth = 0;
  double screenHeight = 0;
  double containerHeight = 0;
  WorkoutAPI woapi = new WorkoutAPI();

  Widget customButton(String ikon,String teks,String indeks){
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = indeks;
        });
      },
      child: Container(
        width: containerHeight,
        height: containerHeight,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: (selected == indeks) ? base.frontColor : Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image(
                  image: AssetImage(ikon),
                  width: containerHeight*0.5,
                  height: containerHeight*0.5
              ),
            ),
            // Text
            Center(
              child: Text(
                teks,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: containerHeight * 0.12
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    containerHeight = screenWidth *0.4;
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: base.backColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          screenHeight / 10,
                          0,
                          screenHeight /10),
                      child: Text(
                          'What is your gender?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customButton(base.arms,"Arms","arms"),customButton(base.abs,"Abs","belly")
                      ]
                    ),
                    SizedBox(height: 30),
                    customButton(base.legs,"Legs","legs"),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom:screenHeight*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                    return Home();
                                  })
                              );
                            },
                            child: Text("Back", style: TextStyle(color: base.frontColor)),
                            style: ElevatedButton.styleFrom(
                              primary: base.backColor,
                              fixedSize: Size(screenWidth*0.4, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: base.frontColor)
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (selected == "ass") {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('please choose your muscle'),
                                ));
                              } else {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString(base.body, selected);
                                pref.setInt(base.daycount, 1);
                                await woapi.newWorkout(context);
                                // print(pref.getString(base.gender) ?? '');
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                      return Home();
                                    })
                                );
                              }
                            },
                            child: Text("Confirm"),
                            style: ElevatedButton.styleFrom(
                              primary: base.frontColor,
                              fixedSize: Size(screenWidth*0.4, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}
