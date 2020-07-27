import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:state_login/homepage.dart';
import 'package:state_login/models/assignTask.dart';
import 'package:state_login/models/assignedBymemodel.dart';
import 'package:state_login/models/assignedTomemodel.dart';
import 'package:state_login/models/selftask.dart';
import 'package:state_login/models/selftasklistmodel.dart';
import 'package:state_login/models/users.dart';
import 'package:state_login/notifiers/auth_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_login/pages/initialPages/signup.dart';

var userId;
GoogleSignInAccount _currentUser;
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

Future<void> handleSignIn(AuthNotifier authNotifier) async {
  try {
    await _googleSignIn.signIn();
    print('object');
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) async {
      _currentUser = account;
      user.id = _currentUser.id;
      print("userid: ${user.id}");
      user.name = _currentUser.displayName;
      user.mail = _currentUser.email;
      //stroing data in our database
      var response = await http.post(
          'http://10.0.2.2:3000/:users/input/${user.id}',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body:
              jsonEncode(user.toMap())); //calling api to store data of new user
      if (response.statusCode == 200 && response.body == "user saved") {
        if (user.id != null) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('userid', user.id.toString());
          authNotifier.setGUser(_currentUser);
          // authNotifier.setUser(pref.getString('userid'));
        }
      } else if (response.statusCode == 1062) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userid', user.id.toString());
        authNotifier.setUser(pref.getString('userid'));
      }
    });
  } catch (error) {
    print(error);
  }
}

Future<void> handleSignOut(AuthNotifier authNotifier) async {
  // signout(authNotifier);
  _googleSignIn.disconnect();
}

//static const String url = 'http://10.0.2.2:3000/own/1';

getUsers(id) async {
  List<User> userdata;
  print(id + "-------------------------------");
  //List<User> task;
  var response = await http.get('http://10.0.2.2:3000/users/$id');
  if (response.statusCode == 200) {
    //
    userdata = (json.decode(response.body) as List)
        .map((e) => User.fromJson(e))
        .toList();
    print(userdata);
    return userdata;
  } else {
    print('error with server');
  }
}

login(User user, AuthNotifier authNotifier) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var response = await http.get(
      'http://10.0.2.2:3000/users/auth/${user.mail}/${user.password}'); //calling the api to get id of user
  print('after get');
  if (response.statusCode == 200 && response.body != "no user found") {
    //true if user loggedin successfully
    print('true condition');
    userId = response.body.toString(); // storing the id to variable->userid
    print(response.body.toString());
    //st=Status.Authenticated;
    if (userId != null) {
      await pref.setString('userid', userId);
      print(pref.getString('userid'));
      print("Login : $userId");
      authNotifier.setUser(pref.getString('userid'));
    }
  }
}

signup(id, User user, AuthNotifier authNotifier) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(jsonEncode(user.toMap()));
  print("Shubham");
  var response = await http.post('http://10.0.2.2:3000/:users/input/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(user.toMap())); //calling api to store data of new user
  print("Shubham1");
  if (response.statusCode == 200 && response.body == "user saved") {
    user.id = id;
    if (user.id != null) {
      pref.setString('userid', id.toString());
      authNotifier.setUser(pref.getString('userid'));
    }
    print("Shubham2");
    return true;
  } else {
    return false;
  }
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final String user = pref.getString('userid');

  if (user != null) {
    print(user);
    authNotifier.setUser(user);
  }

  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    _currentUser = account;
    // userId=_currentUser.id;
    authNotifier.setGUser(_currentUser);
  });
  _googleSignIn.signInSilently();
}

signout(AuthNotifier authNotifier) async {
  userId = null;
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('userid', null);
  authNotifier.setUser(null);
}

getselftask(id) async {
  List<SelfTaskListModel> task;
  print(id);
  var response = await http.get('http://10.0.2.2:3000/users/$id/selftasks');
  if (response.statusCode == 200) {
    task = (json.decode(response.body) as List)
        .map((e) => SelfTaskListModel.fromJson(e))
        .toList();
    print(task);
    return task;
  } else {
    print('error with server');
  }
}

assignTaskToOther(Assigntask at) async {
  var map = {
    "title": at.title,
    "desc": at.desc,
    "date": at.date,
    "status": at.status,
  };
  var response = await http.put(
      'http://10.0.2.2:3000/users/${at.id}/assigntask/${at.tid}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(map));
  print(response.body);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "error";
  }
}

assignSelfTask(Selftask st) async {
  print(st.toMap());
  var response = await http.put(
      'http://10.0.2.2:3000/:users/${st.id}/assignselftask',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(st.toMap()));
  print(response.body);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "error";
  }
}

getAllAssignedTaskToMe(id) async {
  List<AssignedToMeModel> task = [];
  var response = await http.get('http://10.0.2.2:3000/users/$id/asstasks');
  if (response.statusCode == 200) {
    task = (json.decode(response.body) as List)
        .map((e) => AssignedToMeModel.fromJson(e))
        .toList();
    return task;
  } else {
    return 'error';
  }
}

getAllAssignedTaskByMe(id) async {
  List<AssignedByMeModel> task = [];
  var response = await http.get('http://10.0.2.2:3000/users/$id/asstasksbyme');
  if (response.statusCode == 200) {
    task = (json.decode(response.body) as List)
        .map((e) => AssignedByMeModel.fromJson(e))
        .toList();
    return task;
  } else {
    return 'error';
  }
}

updateSelfTask(oldtitle, olddate, String id, newTitle, newDate, newDesc) async {
  var map = {
    "title": oldtitle.toString(),
    "date": olddate.toString(),
    "utitle": newTitle.toString(),
    "udesc": newDesc.toString(),
    "udate": newDate.toString()
  };
  print(map);
  print(id);
  var response = await http.put('http://10.0.2.2:3000/users/updateSelf/$id',
      headers: <String, String>{
        "Content-Type": "application/json;charset=UTF-8"
      },
      body: json.encode(map));
  if (response.statusCode == 200 && response.body == 'done') {
    print('updated');
    return true;
  } else {
    print('error');
    return false;
  }
}

updateAssignedTaskToOther(
    oldTitle, oldDate, oldtid, id, AssignedByMeModel am) async {
  var map = {
    "title": oldTitle,
    "date": oldDate,
    "tid": oldtid,
    "utitle": am.title,
    "udesc": am.desc,
    "utid": am.tid,
    "udate": am.date
  };
  var response = await http.put('http://10.0.2.2:3000/users/updateAssA/$id',
      headers: <String, String>{
        "Content-Type": "application/json;charset=UTF-8"
      },
      body: json.encode(map));
  if (response.statusCode == 200 && response.body == 'done') {
    print('updated');
    return true;
  } else {
    print('error');
    return false;
  }
}

completeSelfTask(id, title, date) async {
  var response = await http.put('http://10.0.2.2:3000/users/comselftask/$id',
      body: json.encode({"title": title, "date": date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
  if (response.statusCode == 200 && response.body == "done") {
    print('complete');
    return true;
  } else {
    return false;
  }
}

completeAssignedToMeTask(tid, title, date) async {
  var response = await http.put('http://10.0.2.2:3000/users/comAssWtask/$tid',
      body: json.encode({"title": title, "date": date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
  if (response.statusCode == 200 && response.body == "done") {
    print('complete');
    return true;
  } else {
    return false;
  }
}

completeAssignedByMeTask(id, title, tid, date) async {
  var response = await http.put('http://10.0.2.2:3000/users/comAssAtask/$id',
      body: json.encode({"title": title, "tid": tid, "date": date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
  if (response.statusCode == 200 && response.body == "done") {
    print('complete');
    return true;
  } else {
    return false;
  }
}

deleteSelfTask(id, title, date) async {
  var response = await http.put('http://10.0.2.2:3000/users/deleteself/$id',
      body: json.encode({"title": title, "date": date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
  if (response.statusCode == 200 && response.body == "done") {
    print('complete');
    return true;
  } else {
    return false;
  }
}

deleteAssignedByMe(id, title, tid, date) async {
  var response = await http.put('http://10.0.2.2:3000/users/deleteAssA/$id',
      body: json.encode({"title": title, "tid": tid, "date": date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
  if (response.statusCode == 200 && response.body == "done") {
    print('complete');
    return true;
  } else {
    return false;
  }
}

deleteAssignedToMe(tid, title, date) async {
  var response = await http.put('http://10.0.2.2:3000/users/deleteAssW/$tid',
      body: json.encode({"title": title, "date": date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
  if (response.statusCode == 200 && response.body == "done") {
    print('complete');
    return true;
  } else {
    return false;
  }
}
