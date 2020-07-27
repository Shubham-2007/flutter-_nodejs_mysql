import 'package:flutter/material.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/models/users.dart';

class Settingpage extends StatefulWidget {
  final id;

  const Settingpage({Key key, this.id}) : super(key: key);

  @override
  _SettingpageState createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  List<String> option = [
    'Feedback',
    'About Us',
    'Invite a Friend',
    'Notification',
    'Dark Mode',
    'Sign Out',
  ];

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(shrinkWrap: true, children: <Widget>[
          //width: MediaQuery.of(context).size.width,
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(246, 246, 250, 3),
                    Color.fromRGBO(215, 215, 222, 3)
                  ]),
              //color: Color.fromRGBO(215, 215, 222, 3)
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(138, 83, 199, 1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(159, 98, 228, 1),
                            //offset: Offset(10.0, 0.0),
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    height: 325,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Color.fromRGBO(159, 98, 228, 20)
                                          .withOpacity(0.85),
                                      BlendMode.dstATop),
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage('asset/abc.png')),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromRGBO(159, 98, 228, 1),
                                  //offset: Offset(10.0, 0.0),
                                  blurRadius: 20.0,
                                  spreadRadius: 10.0,
                                ),
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                            child: FutureBuilder(
                                future: getUsers(widget.id),
                                builder: (context, snapshot) {
                                  return Container(
                                    child: Text(
                                      snapshot.data[0].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                      ),
                                    ),
                                  );
                                }),
                          
                        ),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //   child: Text(
                        //     //"50 Remaining  |  50 Completed",
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: Color.fromRGBO(221, 221, 228, 1),
                          //width: 2
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(221, 221, 228, 1),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.share,
                                //color: Colors.white,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            //color: Color.fromRGBO(15, 228, 0, 1),
                          ),
                          Container(
                            child: Text("Feedback",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(139, 139, 143, 1))),
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          ),
                          Container(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(190, 0.0, 0, 0.0),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  //   height: 500,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ListView.builder(
                  //       itemCount: 6,
                  //       itemBuilder: (context, index) {
                  //         return Container(
                  //           decoration: BoxDecoration(
                  //               color: Color.fromRGBO(255, 255, 255, 1),
                  //               border: Border.all(
                  //                 color: Color.fromRGBO(221, 221, 228, 1),
                  //                 //width: 2
                  //               ),
                  //               boxShadow: <BoxShadow>[
                  //                 BoxShadow(
                  //                   color: Color.fromRGBO(221, 221, 228, 1),
                  //                   offset: Offset(0.0, 3.0),
                  //                   blurRadius: 5.0,
                  //                   spreadRadius: 5.0,
                  //                 ),
                  //               ]),
                  //           height: 55,
                  //           width: MediaQuery.of(context).size.width,
                  //           child: MaterialButton(
                  //             onPressed: () {},
                  //             child: Row(
                  //               children: <Widget>[
                  //                 Icon(Icons.sentiment_very_satisfied,
                  //                     //color: Colors.white,
                  //                     size: 30,
                  //                     color: Color.fromRGBO(139, 139, 143, 1)),
                  //                 Container(
                  //                   child: Text(option[index],
                  //                       style: TextStyle(
                  //                           fontSize: 20,
                  //                           color: Color.fromRGBO(
                  //                               139, 139, 143, 1))),
                  //                   padding: EdgeInsets.fromLTRB(
                  //                       20.0, 0.0, 0.0, 0.0),
                  //                 ),
                  //                 Icon(Icons.arrow_forward_ios,
                  //                     size: 30,
                  //                     color: Color.fromRGBO(139, 139, 143, 1)),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  // ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: Color.fromRGBO(221, 221, 228, 1),
                          // width: 2
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(221, 221, 228, 1),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.account_circle,
                                //color: Colors.white,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            //color: Color.fromRGBO(15, 228, 0, 1),
                          ),
                          Container(
                            child: Text("About Us",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(139, 139, 143, 1))),
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          ),
                          Container(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(195, 0.0, 0, 0.0),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: Color.fromRGBO(221, 221, 228, 1),
                          //width: 2
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(221, 221, 228, 1),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.share,
                                //color: Colors.white,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            //color: Color.fromRGBO(15, 228, 0, 1),
                          ),
                          Container(
                            child: Text("Invite a friend",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(139, 139, 143, 1))),
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          ),
                          Container(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(155, 0.0, 0, 0.0),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: Color.fromRGBO(221, 221, 228, 1),
                          // width: 2
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(221, 221, 228, 1),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.notifications_active,
                                //color: Colors.white,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            //color: Color.fromRGBO(15, 228, 0, 1),
                          ),
                          Container(
                            child: Text("Notification",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(139, 139, 143, 1))),
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          ),
                          Container(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(173, 0.0, 0, 0.0),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: Color.fromRGBO(221, 221, 228, 1),
                          //width: 2
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(221, 221, 228, 1),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.brightness_6,
                                //color: Colors.white,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            //color: Color.fromRGBO(15, 228, 0, 1),
                          ),
                          Container(
                            child: Text("Dark Mode",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(139, 139, 143, 1))),
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          ),
                          Container(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(180, 0.0, 0, 0.0),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: Color.fromRGBO(221, 221, 228, 1),
                          // width: 2
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(221, 221, 228, 1),
                            offset: Offset(0.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.last_page,
                                //color: Colors.white,
                                size: 35,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            //color: Color.fromRGBO(15, 228, 0, 1),
                          ),
                          Container(
                            child: Text("Sign Out",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(139, 139, 143, 1))),
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          ),
                          Container(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 30,
                                color: Color.fromRGBO(139, 139, 143, 1)),
                            padding: EdgeInsets.fromLTRB(197, 0.0, 0, 0.0),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "from",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.1,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "AUGMETIC",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
