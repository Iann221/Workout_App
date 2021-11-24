import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:flutter_dss/pages/body.dart';
import 'package:flutter_dss/historymodel.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {


  @override
  _HistoryState createState() => _HistoryState();
}

List<HistoryModel> historyListDummy = [
  HistoryModel(date: 1111, mood: 'I''m Happy', pain: 'I don''t feel anything'),
  HistoryModel(date: 1222, mood: 'I''m Happy', pain: 'I don''t feel anything'),
  HistoryModel(date: 1333, mood: 'I''m Happy', pain: 'I don''t feel anything'),
  HistoryModel(date: 1444, mood: 'I''m Happy', pain: 'I don''t feel anything'),
];

List<Widget> cards = [];
// for (var v in historyList){
//   cards.add(historyCard(v.date, v.mood, v.pain, v.body));
// };

class _HistoryState extends State<History> {

  Widget historyCard(int date, String mood, String pain){
    var dt = DateFormat.yMMMd(date);
    return Center(
        child: Card(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal:20.0),
            color: base.backColor,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    //   width: MediaQuery.of(context).size.width/2 - 10,
                      alignment: Alignment.topLeft,

                      child: Text("$date",
                          style: new TextStyle(
                              color: base.fontColor,
                              fontSize: 18
                          ),
                          textAlign: TextAlign.left)
                  ),
                  Container(

                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 3.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$mood",
                              style: new TextStyle(
                                  color: base.fontColor, fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 3.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$pain",
                              style: new TextStyle(
                                  color: base.fontColor, fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                        ],
                      )
                  )
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    //dummy historyList

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: base.backColor,
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      10,
                      MediaQuery.of(context).size.height / 10,
                      10,
                      MediaQuery.of(context).size.height / 40),
                  child: Text(
                      "History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: base.fontColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      )),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height / 80)
                ),


                // Back to Home
                ElevatedButton(
                  onPressed: () async {},
                  child: Text("Back to Home", style: TextStyle(color: base.frontColor)),
                  style: ElevatedButton.styleFrom(
                    primary: base.backColor,
                    fixedSize: Size(MediaQuery.of(context).size.height*0.9, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: base.frontColor)
                    ),
                  ),
                ),

                Padding(
                    padding: EdgeInsets.symmetric(vertical:10.0)
                ),
                SingleChildScrollView(
                    child: Column(
                      children: historyListDummy.map((historyDay) => historyCard(historyDay.date, historyDay.mood, historyDay.pain))
                    )
                  )
                // )
              ]
          ),
        ),
      ),
    );
  }

}

class HistoryCardState extends StatelessWidget {
  const HistoryCardState({Key? key}) : super(key: key);

  // Widget historyCard(int date, String mood, String pain, String bodyPart){
  //   var dt = DateFormat.yMMMd(date);
  //   return Center(
  //       child: Card(
  //           margin: EdgeInsets.symmetric(vertical: 5.0, horizontal:20.0),
  //           color: base.backColor,
  //           child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Container(
  //                   //   width: MediaQuery.of(context).size.width/2 - 10,
  //                     alignment: Alignment.topLeft,
  //
  //                     child: Text("$date",
  //                         style: new TextStyle(
  //                             color: base.fontColor,
  //                             fontSize: 18
  //                         ),
  //                         textAlign: TextAlign.left)
  //                 ),
  //                 Container(
  //
  //                     alignment: Alignment.centerLeft,
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           padding: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 3.0),
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             "$mood",
  //                             style: new TextStyle(
  //                                 color: base.fontColor, fontSize: 14
  //                             ),
  //                             textAlign: TextAlign.left,
  //                           ),
  //                         ),
  //
  //                         Container(
  //                           padding: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 3.0),
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             "$pain",
  //                             style: new TextStyle(
  //                                 color: base.fontColor, fontSize: 14
  //                             ),
  //                             textAlign: TextAlign.left,
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.fromLTRB(5.0, 3.0, 0.0, 3.0),
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             "$bodyPart",
  //                             style: new TextStyle(
  //                                 color: base.fontColor, fontSize: 14
  //                             ),
  //                             textAlign: TextAlign.left,
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                 )
  //               ]
  //           )
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal:10.0),
        color: base.backColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
            width: MediaQuery.of(context).size.width/2 - 10,
            alignment: Alignment.topLeft,
                child: Text("DD mmm YYYY",
                  style: new TextStyle(
                      color: base.fontColor,
                      fontSize: 18
                  ),
                  textAlign: TextAlign.left)
            ),
            Container(
              width: MediaQuery.of(context).size.width/2 - 10,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    "Mood",
                    style: new TextStyle(
                        color: base.fontColor, fontSize: 14
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text("Pain",
                    style: new TextStyle(
                        color: base.fontColor, fontSize: 14
                    ),
                    textAlign: TextAlign.left,),
                  Text("Bodypart",
                    style: new TextStyle(
                        color: base.fontColor, fontSize: 14
                    ),
                    textAlign: TextAlign.left,),
                ],
              )
            )
          ]
        )
      ),
    );
  }
}

