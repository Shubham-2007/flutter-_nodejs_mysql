class SelfTaskListModel {
  String id;
  String title;
  String date;
  String desc;
  String status;

  SelfTaskListModel();

  SelfTaskListModel.fromJson(data) {
    id = data['id'];
    title = data['title'];
    desc = data['descp'];
    date = data['date'];
    status = data['status'];
  }
}
