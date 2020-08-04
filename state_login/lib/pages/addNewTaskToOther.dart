import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/contacts.dart';
import 'package:state_login/models/assignTask.dart';
import 'package:state_login/models/contactdetail.dart';
import 'package:state_login/transfernotification.dart';

class AddNewTaskForOther extends StatefulWidget {
  final id;

  const AddNewTaskForOther({Key key, this.id}) : super(key: key);
  @override
  _AddNewTaskForOtherState createState() => _AddNewTaskForOtherState();
}

class _AddNewTaskForOtherState extends State<AddNewTaskForOther> {
  var selectedContact;
  Assigntask at = Assigntask();
  var selectedDate = DateTime.now();
  final fkey = GlobalKey<FormState>();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmessage();
    at.id = widget.id;
    at.status = 0;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController titleController =
      TextEditingController(text: 'Subtile');
  final TextEditingController bodyController =
      TextEditingController(text: 'Body123');
  final List<Message> messages = [];
  int i = 0;

  void getmessage() {
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    //   _firebaseMessaging.getToken();
    //_firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    print('***///////////////////////////////////////');

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(" onMessage: $message");
        final notification = message['notification'];
        setState(() {
          //    messages.add(Message(
          //       title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message['data'];
        setState(() {
          // messages.add(Message(
          //   title: '${notification['title']}',
          //   body: '${notification['body']}',
          // ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  Future sendNotification() async {
    getmessage();
    final response = await Messaging.sendToTopic(
      title: at.title,
      body: at.desc,
      usertoken:
          "dRgjGgTkaSQ:APA91bHNLyv55XpY-GvoFlNSv_GHRnrpKzsQM2UNcpuQGtIDZ2A3SVLdPBblGhH7_8C8oqi5Dyi_EtrFDzoJxrXuO_Z4io6iJpUspGisEbg22PnRIrA6KtHaASLYUwb2vCueuV9Nn3Jh",
    );
    if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            '[${response.statusCode}] Error message------------------------------------------: ${response.body}'),
      ));
    }
  }

  String sendTokenToServer(String fcmToken) {
    print('Token: $fcmToken');
   
    return fcmToken;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Form(
        key: fkey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'New Task',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.outlined_flag,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                onPressed: () async {
                  if (fkey.currentState.validate()) {
                    if (await assignTaskToOther(at) == 'task added') {
                      sendNotification();
                      print('added');
                      setState(() {
                        print('added');
                      });
                    } else {
                      print('cant add task');
                    }
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      border: InputBorder.none),
                  onChanged: (String val) => at.title = val,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: InkWell(
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                          at.date = selectedDate.toString();
                        });
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$selectedDate',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.date_range)
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: FutureBuilder<List<ContactDetail>>(
                  future: refreshContacts(),
                  builder: (context, snapshot) {
                    print("***************1");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("***************2");
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return DropdownButton<String>(
                        hint: Text('Select People'),
                        value: selectedContact,
                        underline: Container(),
                        onChanged: (value) {
                          setState(() {
                            selectedContact = value;
                            at.tid = selectedContact;
                            print("at.tid: ${at.tid}");
                            print(selectedContact);
                            print("***************3");
                          });
                        },
                        items: snapshot.data.map((e) {
                          print("snapshot.data.length ${snapshot.data.length}");
                          return DropdownMenuItem<String>(
                            child: Text(e.name),
                            value: e.id,
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 20.0)),
                  onChanged: (String val) => at.desc = val,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
