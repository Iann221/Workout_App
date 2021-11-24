import 'dart:convert';
import 'package:flutter_dss/historymodel.dart';
import 'package:flutter_dss/workout_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dss/base.dart' as base;
import 'package:http/http.dart' as http;
import 'package:flutter_dss/workout_model.dart';

class WorkoutAPI {
  String token = "";
  int daycount = 0;

  // get Program
  Future<Program> getProgram() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // get token
    token = pref.getString(base.token)!;
    print(token);

    // get info mood dan pain
    String mood = await pref.getString(base.mood)!;
    String pain = await pref.getString(base.pain)!;
    String body = await pref.getString(base.body)!;
    print(body);
    print(mood);
    print(pain);

    var url = Uri.parse(base.url + base.generateOneDay + '?mood=' + mood + '&pain=' + pain);
    print(url);

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
    daycount = (pref.getInt(base.daycount) ?? 0) + 1;
    pref.setInt(base.daycount, daycount);

    // add history
    // addHistory(decoded, mood, pain);

    return program;
  }

  // Future<List<HistoryModel>> getHistory() async{
  //   var url = Uri.parse(base.url + base.historyURL);
  //   var response = await http.get(
  //       url,
  //       headers: {
  //         "Authorization" : token
  //       }
  //
  //
  //   );
  //   Map<String, dynamic> historyRaw = jsonDecode(response.body)['data'];
  //   // Program program = Program.fromJSON(decoded);
  //   // print('mode:');
  //   // print(program.workout[0].desc[0]);
  //   List<HistoryModel> historyList = [];
  //   for (var h in historyRaw){
  //     historyList.add(new HistoryModel(h.date, h.mood, h.pain))
  //   }
  //
  //   return historyList;
  // }

  Future<void> addHistory(Map<String, dynamic> json, String mood, String pain) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // get token
    token = pref.getString(base.token)!;
    var url = Uri.parse(base.url + base.newWorkout);
    print(url);

    var response = await http.post(
        url,
        headers: {
          "Authorization" : token
        },
        body: {
          "workout": json['workout'],
          "mood": mood,
          "pain": pain,
          "mode": json['mode']
        }
    );
    print('add to history:' + response.body);

  }

  // new Workout
  Future<void> newWorkout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // get token
    token = pref.getString(base.token)!;
    print(token);

    // get info mood dan pain
    String body = await pref.getString(base.body)!;
    String duration = await pref.getString(base.duration)!;
    String gender = await pref.getString(base.gender)!;
    print('body yg diapi:' + body);

    var url = Uri.parse(base.url + base.newWorkout);
    print(url);

    var response = await http.post(
        url,
        headers: {
          "Authorization" : token
        },
        body: {
          "gender": gender,
          "bodyPart": body,
          "duration": duration,
        }
    );
    print(response.body);
    print(response.statusCode);
  }

  Future<void> login(email,password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(email);
    print(password);
    var url = Uri.parse(base.url + base.login);
    print(url);

    var response = await http.post(
        url,
        body: {
          "email": email,
          "password": password,
        }
    );
    pref.setString(base.token, jsonDecode(response.body)['token']);
  }
}
