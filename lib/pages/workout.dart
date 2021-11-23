import 'package:flutter/material.dart';
import 'package:flutter_dss/pages/pain.dart';
import 'package:flutter_dss/workout_api.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/workout_model.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  double screenWidth = 0;
  double screenHeight = 0;
  double cardHeight = 0;
  WorkoutAPI woapi = new WorkoutAPI();
  // List<Workout> _displayed = [];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    cardHeight = screenHeight*0.1;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:_buildPage()
        )
      ),
    );
  }

  Widget _buildWorkout(Workout wo){
    return Container(
      height: cardHeight,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey)
            ),
        ),
      child: Row(
        children: [
          Text(
            wo.name ?? 'no data',
            style: TextStyle(
                color: Colors.white,
                fontSize: cardHeight*0.3
            ),
          ),
          Spacer(),
          Text(
            wo.repetition.toString() + 'x',
            style: TextStyle(
                color: Colors.white,
                fontSize: cardHeight*0.3
            ),
          ),
        ]
      )
    );
  }

  Widget _buildPage(){
    WorkoutAPI workoutAPI = new WorkoutAPI();
    workoutAPI.getProgram();
    return Container(
      color: base.backColor,
      child: FutureBuilder(
        future: woapi.getProgram(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            Program prg = snapshot.data;
            // _displayed = prg.workout.cast<Workout>();
            return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenHeight * 0.05,
                        screenHeight * 0.05,
                        screenHeight * 0.05,
                        screenHeight * 0.05),
                    child: Text(
                        "Here's what you need to do",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          prg.time ?? 'no data',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(
                          prg.set.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Text(
                          prg.mode ?? 'no mode',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0,
                        screenHeight * 0.05,
                        0,
                        screenHeight * 0.05),
                    child: ElevatedButton(
                      onPressed: () async {
                        // print(pref.getString(base.duration) ?? '');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                              return Pain();
                            })
                        );
                      },
                      child: Text("I'm Ready"),
                      style: ElevatedButton.styleFrom(
                        primary: base.frontColor,
                        fixedSize: Size(screenWidth*0.8, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: prg.workout.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){
                      return _buildWorkout(prg.workout[index]);
                    },
                  )
                ]
            );
          }
        }
      ),
    );
    // return Container(
    //   child: FutureBuilder(
    //     initialData: [],
    //     future: ,
    //     builder: (BuildContext context, AsyncSnapshot snapshot){
    //       if (snapshot.connectionState != ConnectionState.done) {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //
    //     }
    //
    //   )
    // );
  }
}
