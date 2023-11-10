class Task{
  int? id;
  int? isCompleted;
  int? color;
  int? remind;
  String? title;
  String? content;
  String? date;
  String? startTime;
  String? repeat;
 Task({this.date,this.content,this.title,this.color,this.id,this.isCompleted,this.remind,this.repeat,this.startTime});
 Map<String, dynamic> toJson(){
   final Map<String, dynamic> data = new Map<String, dynamic>();
   data['id'] = this.id;
   data['title'] = this.title;
   data['content'] = this.content;
   data['date'] = this.date;
   data['startTime'] = this.startTime;
   data['color'] = this.color;
   data['isCompleted'] = this.isCompleted;
   data['repeat'] = this.repeat;
   data['remind'] = this.remind;
   return data;
 }
 Task.fromJson(Map<String , dynamic>json){
   id = json['id'];
   title = json['title'];
   content = json['content'];
   date = json['date'];
   startTime = json['startTime'];
   color = json['color'];
   isCompleted = json['isCompleted'];
   repeat = json['repeat'];
   remind = json['remind'];
 }
}
