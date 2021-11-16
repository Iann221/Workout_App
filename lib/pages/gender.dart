import 'package:flutter/material.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:shared_preferences/shared_preferences.dart';

class Gender extends StatefulWidget {

  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String selected = "waria";
  double screenWidth = 0;
  double screenHeight = 0;
  double containerHeight = 0;

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
                  image: AssetImage(base.male),
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
              customButton(base.male,"Male","Male"),
              SizedBox(height: 30),
              customButton(base.male,"Female","Female"),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom:screenHeight*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('hihi');
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
                        if (selected == "waria") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('please choose your gender'),
                          ));
                        } else {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.setString(base.gender, selected);
                          // print(pref.getString(base.gender) ?? '');
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
