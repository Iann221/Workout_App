import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/workout_model.dart';
import 'package:flutter_dss/pages/home.dart';

class Doing extends StatefulWidget {
  List<Workout> wos;
  int set;
  int seq;


  Doing({required this.wos, required this.set, required this.seq});

  @override
  _DoingState createState() => _DoingState(this.wos,this.set,this.seq);
}

class _DoingState extends State<Doing> {
  _DoingState(this.wos,this.set,this.seq);
  List<Workout> wos;
  int set;
  int seq;

  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    print(wos[seq].name);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: base.backColor,
          child: Column(
            children: [
              Image(
                  image: AssetImage(base.pushup),
                  width: screenWidth
              ),
              ElevatedButton(
                onPressed: () async {
                  // print(pref.getString(base.duration) ?? '');
                  if(seq!=wos.length-1){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                          return Doing(wos:wos,set:set,seq:(seq+1));
                        })
                    );
                  } else {
                    if(set==1){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                            return Home();
                          })
                      );
                    } else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                            return Doing(wos:wos, set: set-1,seq:0);
                          })
                      );
                    }
                  }
                },
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  primary: base.frontColor,
                  fixedSize: Size(screenWidth*0.8, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
