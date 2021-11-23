class Program {
  String? time;
  int? set;
  String? mode;
  List<Workout> workout = [];

  Program({
    required this.time,
    required this.set,
    required this.mode,
    required this.workout
  });

  Program.fromJSON(Map<String, dynamic> json){
    this.time = json['time'];
    this.set = json['set'];
    this.mode = json['mode'];
    for (var i = 0; i < json['workout'].length; i++){
      Workout wo = Workout.fromJSON(json['workout'][i]);
      this.workout.add(wo);
    }
  }

}

class Workout {
  String? name;
  int? repetition;
  List<String> desc = [];

  Workout({
    required this.name,
    required this.repetition,
    required this.desc
  });

  Workout.fromJSON(Map<String, dynamic> json){
    this.name = json['name'];
    this.repetition = json['repetition'];
    for (var i = 0; i < json['description'].length; i++){
      this.desc.add(json['description'][i]);
    }
  }
}