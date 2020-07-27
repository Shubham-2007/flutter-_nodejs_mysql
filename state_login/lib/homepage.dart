import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/models/contactdetail.dart';
import 'package:state_login/notifiers/auth_notifier.dart';
import 'package:state_login/pages/addNewSelfTask.dart';
import 'package:state_login/pages/addNewTaskToOther.dart';
import 'package:state_login/pages/assignedToMetasklist.dart';
import 'package:state_login/pages/assignedtasklist.dart';
import 'package:state_login/pages/selftasklist.dart';
import 'package:state_login/pages/settingpage.dart';

class Task extends StatefulWidget {
  final id;
  const Task({Key key, this.id}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> with SingleTickerProviderStateMixin {
  var sckey = GlobalKey<ScaffoldState>();
  var selectedDate = DateTime.now();
  List<ContactDetail> contactdetaillist; //contacts list

  PageController controller = PageController(viewportFraction: 0.9);
  int currentPage;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    setState(() {
      pages = [
        SelfTaskList(
          id: widget.id,
        ),
        AssignedToMeTask(id: widget.id),
        AssignedTask(id: widget.id)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier auth = Provider.of<AuthNotifier>(context);
    return Scaffold(
      key: sckey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black87,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Settingpage(id: widget.id,)));
              //  signout(auth);
              //  handleSignOut(auth);
            },
          )
        ],
      ),
      body: PageView.builder(
          itemCount: 3,
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
              print(currentPage.toInt());
              print( "//////////////////////////////"+widget.id);
            });
          },
          pageSnapping: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, position) =>
              SafeArea(child: Card(elevation: 25.0, child: pages[position]))),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            minWidth: 60.0,
            height: 60,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0)),
            child: Icon(
              Icons.content_paste,
              color: Colors.white,
              size: 30,
            ),
            color: Color.fromRGBO(159, 98, 228, 20),
            onPressed: () {
              // openselftasksheet(context,widget.id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewSelfTask(
                            id: widget.id,
                          )));
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          MaterialButton(
            minWidth: 60.0,
            height: 60,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Icon(
              Icons.perm_contact_calendar,
              color: Colors.white,
              size: 30,
            ),
            color: Color.fromRGBO(159, 98, 228, 20),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewTaskForOther(
                            id: widget.id,
                          )));
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Yash Paneliya'),
              accountEmail: Text('yash@gmail.com'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   notchMargin: 35.0,
      //   shape: CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //           margin: EdgeInsets.only(left: 10.0),
      //           child: IconButton(
      //               icon: Icon(Icons.menu),
      //               onPressed: () {
      //                 setState(() {
      //                   sckey.currentState.openDrawer();
      //                 });
      //               })),
      //     ],
      //   ),
      // ),
    );
  }
}
