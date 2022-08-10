class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? Stime;
  String? Etime;
  int? color;
  String? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.Stime,
    this.Etime,
    this.color,
    this.remind,
    this.repeat,
  });

  Task.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    Stime = json['Stime'];
    Etime = json['Etime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['Stime'] = Stime;
    data['Etime'] = Etime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;
    return data;
  }
}