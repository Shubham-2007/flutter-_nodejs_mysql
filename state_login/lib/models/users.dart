class User {
  String name;
  String last;
  var mail;
  var password;
  var number;
  var id;

  User();
  
  User.fromJson(data) {
    name = data['username'].toString();
    last = data['lastname'].toString();
    // mail = data['mail'];
    // number = data['number'];
    // password = data['password'];
  }

  User.fromMap(Map<dynamic, dynamic> data) {
    name = data['username'];
    last = data['lastname'];
    mail = data['mail'];
    password = data['password'];
    number = data['number'];
  }

  Map<String, String> toMap() {
    return {
      "username": "$name",
      "lastname": "$name",
      "mail": "$mail",
      "number": "$number",
      "password": "$password",
    };
  }
}
