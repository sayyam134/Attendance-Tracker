class Subject{
  String subjectName;
  int totDay;
  int pDay;

  Subject({
    required this.subjectName,
    required this.totDay,
    required this.pDay,
  }

  );

  // a constructor that convert json to object
  Subject.fromJson(Map<String,dynamic> json): subjectName=json['subjectName'],
        totDay=json["totDay"],
        pDay=json["pDay"];

  // a method that convert object to json string
  Map<String,dynamic> toJson()=>{
    "subjectName":subjectName,
    "totDay":totDay,
    "pDay":pDay
  };
}