class User {
  var name;
  var last;
  var mail;
  var password;
  var number;
  var id;

  User();

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
