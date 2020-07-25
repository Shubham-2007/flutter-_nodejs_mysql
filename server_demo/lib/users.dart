class User{
  final id;
  final uname;
  final lname;
  final email;
  final phone;

  User({this.id, this.uname, this.lname, this.email, this.phone});

  factory User.fromJson(List<dynamic> json){
    print(json);
    var j=json.elementAt(0);
    print(j);
    return User(
      id:j["id"],
      uname: j["username"],
      lname:j["lastname"],
      email:j["email"],
      phone: j["number"]
    );
  }

}