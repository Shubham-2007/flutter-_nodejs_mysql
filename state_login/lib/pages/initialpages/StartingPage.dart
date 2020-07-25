import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/models/users.dart';
import 'package:state_login/notifiers/auth_notifier.dart';
import 'package:state_login/pages/initialPages/NormalLogin.dart';
import 'package:state_login/pages/initialPages/signup.dart';

class StartingPage extends StatefulWidget {
  @override
  _GloginScreenState createState() => _GloginScreenState();
}

class _GloginScreenState extends State<StartingPage> {
  AuthNotifier authNotifier;

  @override
  void initState() {
    authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
 
            SizedBox(height: 40.0),
            Container(
              height: 40.0,
              width: 200,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.deepPurpleAccent,
                color: Colors.deepPurple,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (contex) => NLogin())
                    );
                  },
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              height: 40.0,
              width: 200,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.deepPurpleAccent,
                color: Colors.deepPurple,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (contex) => Signup())
                    );
                  },
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: (){
                 handleSignIn(authNotifier);
              },
              child: Container(
                height: 40.0,
                width: 200,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Center(
                      //   child: ImageIcon(AssetImage('assets/glogo.png')),
                      // ),
                      SizedBox(width: 10.0),
                      Center(
                        child: Text('Log In with Google',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
