class User {
  var name;
  var last;
  var mail;
  var password;
  var number;
  var id;

  User();

  User.fromJson(data) {
    name = data['username'];
    last = data['lastname'];
    mail = data['mail'];
    number = data['number'];
    password = data['password'];
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

class Album {
  final int userid;
  final String name;
  final String last;
  final String mail;
  final String password;
  final String number;
  Album(
      {this.userid,
      this.name,
      this.last,
      this.mail,
      this.password,
      this.number});

  factory Album.fromJson(Map<String, dynamic> parsedJson) {
    return Album(
      userid: parsedJson['id'] ,
      name: parsedJson['username'] as String,
      last: parsedJson['lastname'],
      mail: parsedJson['mail'],
      password: parsedJson['password'],
      number: parsedJson['number'],
    );
  }
}
