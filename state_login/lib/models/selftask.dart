class Selftask {
  String title;
  String desc;
  String date;
  String id;
  String status;

  Selftask();

  Selftask.fromMap(Map<dynamic, dynamic> data) {
    id = data['uid'];
    title = data['title'];
    desc = data['descp'];
    date = data['date'];
    status = data['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      "title": "$title",
      "descp": "$desc",
      "date": "$date",
      "status": "$status",
    };
  }
}
