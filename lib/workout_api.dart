import 'dart:convert';
import 'package:flutter_dss/historymodel.dart';
import 'package:flutter_dss/workout_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:http/http.dart' as http;
import 'package:flutter_dss/workout_model.dart';

class WorkoutAPI {
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InlhbnlhbkBnbWFpbC5jb20iLCJpYXQiOjE2Mzc1OTAyNzksImV4cCI6MTYzNzYyNjI3OX0.qHGFt8JJPS-NznkwZG5YWYrA1_sBOYyPe5O-SqIG6Wg";
  Future<Program> getProgram() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // get token

    // get info mood dan pain
    // String mood = await sharedPreferences.getString(base.mood)!;
    // String pain = await sharedPreferences.getString(base.pain)!;

    var url = Uri.parse(base.url + base.generateOneDay);

    // request api
    var response = await http.get(
      url,
      headers: {
        "Authorization" : token
      }
    );
    Map<String, dynamic> decoded = jsonDecode(response.body)['data'];
    Program program = Program.fromJSON(decoded);
    // print('mode:');
    // print(program.workout[0].desc[0]);
    return program;
  }

  Future<String> login(String email, String password) async{

    var url = Uri.parse(base.url + base.loginURL);

    // request api
    var response = await http.post(
        url,
        body: {
          "email" : email,
          "password": password
        }
    );
    String token = jsonDecode(response.body)['token'];
    return token;
  }

  Future<List<HistoryModel>> getHistory() async{
    var url = Uri.parse(base.url + base.historyURL);
    var response = await http.get(
        url,
        headers: {
          "Authorization" : token
        }


    );
    Map<String, dynamic> historyRaw = jsonDecode(response.body)['data'];
    // Program program = Program.fromJSON(decoded);
    // print('mode:');
    // print(program.workout[0].desc[0]);
    List<HistoryModel> historyList = [];
    for (var h in historyRaw){
      historyList.add(new HistoryModel(h.date, h.mood, h.pain))
    }

    return historyList;
  }
}

