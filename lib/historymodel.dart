class HistoryModel{
  int date = 0;
  String mood;
  String pain;

  HistoryModel({
    required this.date,
    required this.mood,
    required this.pain
  });

  HistoryModel.fromJSON(Map<String, dynamic> json){
    this.date = json['date'];
    this.mood = json['mood'];
    this.pain = json['pain'];
  }
}

