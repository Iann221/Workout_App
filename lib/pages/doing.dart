import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/workout_model.dart';
import 'package:flutter_dss/pages/home.dart';

class Doing extends StatefulWidget {
  List<Workout> wos;
  int set;
  int seq;
  int now;

  Doing({required this.wos, required this.set, required this.seq, required this.now});

  @override
  _DoingState createState() => _DoingState(this.wos,this.set,this.seq, this.now);
}

class _DoingState extends State<Doing> {
  _DoingState(this.wos,this.set,this.seq,this.now);
  List<Workout> wos;
  int set;
  int seq;
  int now;

  double screenWidth = 0;
  double screenHeight = 0;

  Widget _buildDesc(BuildContext context) {
    return AlertDialog(
      content: ListView.builder(
        itemCount: wos[seq].desc.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return Text(wos[seq].desc[index]);
        },
      ),
      actions: [
        TextButton(
          child: Text('ok'),
          onPressed:(){
            Navigator.pop(context);
          }
        )
      ]
    );
  }

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
              Text(
                  wos[seq].name ?? 'no data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  )
              ),
              Text(
                  'set ' + now.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  )
              ),
              Text(
                  'rep ' + wos[seq].repetition.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  )
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:(BuildContext context)=>_buildDesc(context),
                  );
                },
                child: Text('Description'),
                style: ElevatedButton.styleFrom(
                primary: base.backColor,
                fixedSize: Size(screenWidth*0.8, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                   ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // print(pref.getString(base.duration) ?? '');
                  if(seq!=wos.length-1){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                          return Doing(wos:wos,set:set,seq:(seq+1),now:now);
                        })
                    );
                  } else {
                    if(now==set){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                            return Home();
                          })
                      );
                    } else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                            return Doing(wos:wos, set: set,seq:0,now: now+1);
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
