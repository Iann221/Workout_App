import 'package:flutter/material.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/pages/home.dart';
import 'package:flutter_dss/pages/gender.dart';

class Duration extends StatefulWidget {

  @override
  _DurationState createState() => _DurationState();
}

class _DurationState extends State<Duration> {
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
                          'How much time would you spend on a workout everyday?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    customButton("5-10 minutes","5-10 minutes"),
                    SizedBox(height: 30),
                    customButton("10-15 minutes","10-15 minutes"),
                    SizedBox(height: 30),
                    customButton("15-20 minutes","15-20 minutes"),
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
                                    return Gender();
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
                                  content: Text('please choose your duration preference'),
                                ));
                              } else {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString(base.duration, selected);
                                // print(pref.getString(base.duration) ?? '');
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
