import 'package:flutter/material.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/pages/home.dart';
import 'package:flutter_dss/pages/pain.dart';

class Mood extends StatefulWidget {

  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {
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
                          'How are you feeling today?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    customButton("Spirited","spirited"),
                    SizedBox(height: 30),
                    customButton("Nothing","nothing"),
                    SizedBox(height: 30),
                    customButton("A bit lazy","a bit lazy"),
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
                              if (selected == "") {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('please choose your mood'),
                                ));
                              } else {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString(base.mood, selected);
                                // print(pref.getString(base.duration) ?? '');
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                      return Pain();
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
