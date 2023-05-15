class Note {
  late int id;
  late String title;
  late String details;
  late String user_id;
Note();
  //read only
  Note.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    title = rowMap['title'];
    details = rowMap['details'];
    user_id = rowMap['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['details'] = details;
    map['user_id'] = user_id;
    return map;
  }
}
