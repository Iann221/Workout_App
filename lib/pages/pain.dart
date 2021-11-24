import 'package:flutter/material.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/pages/mood.dart';
import 'package:flutter_dss/pages/home.dart';
import 'package:flutter_dss/pages/workout.dart';

class Pain extends StatefulWidget {

  @override
  _PainState createState() => _PainState();
}

class _PainState extends State<Pain> {
  String selected = "";
  double screenWidth = 0;
  double screenHeight = 0;
  double containerHeight = 0;

  Widget customButton(String teks, String indeks){
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selected = indeks;
        });
      },
      child: Text(teks),
      style: ElevatedButton.styleFrom(
        primary: base.backColor,
        fixedSize: Size(screenWidth*0.7, 40),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: (selected == indeks) ? base.frontColor : Colors.grey)
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
                          'Do you feel any pain right now?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    customButton("I don't feel anything","no"),
                    SizedBox(height: 30),
                    customButton("A little bit","little"),
                    SizedBox(height: 30),
                    customButton("Sore","sore"),
                    SizedBox(height: 30),
                    customButton("I feel pain","pain"),
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
                                    return Mood();
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
                              if (selected == "") {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('please choose your pain level'),
                                ));
                              } else {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString(base.pain, selected);
                                print(pref.getString(base.pain) ?? '');
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                      return WorkoutPage();
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
