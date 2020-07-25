class AssignedToMeModel {
  String id;
  String title;
  String date;
  String desc;
  String tid;
  String status;

  AssignedToMeModel();

  AssignedToMeModel.fromJson(data) {
    id = data['id'];
    title = data['title'];
    desc = data['descp'];
    date = data['date'];
    tid = data['tid'];
    status = data['status'];
  }
}
