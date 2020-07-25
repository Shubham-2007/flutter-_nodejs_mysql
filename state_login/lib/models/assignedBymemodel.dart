class AssignedByMeModel {
  String id;
  String title;
  String date;
  String desc;
  String tid;
  String status;

  AssignedByMeModel();

  AssignedByMeModel.fromJson(data) {
    id = data['id'];
    title = data['title'];
    desc = data['descp'];
    date = data['date'];
    tid = data['tid'];
    status = data['status'];
  }
}
