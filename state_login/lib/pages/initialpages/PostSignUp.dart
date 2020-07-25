import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/notifiers/auth_notifier.dart';
import 'package:state_login/pages/initialPages/StartingPage.dart';
import 'package:state_login/pages/initialPages/signup.dart';

class PostSignup extends StatefulWidget {
  @override
  _PostSignupState createState() => _PostSignupState();
}

class _PostSignupState extends State<PostSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  String _errorMessage;
  AuthNotifier authNotifier;

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    authNotifier=Provider.of<AuthNotifier>(context, listen: false);
    var random = Random.secure();
    int id = random.nextInt(10000000);
    signup(id,user, authNotifier);
    Navigator.popUntil(context, (route) => route.isFirst);
  }


  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 19, color: Colors.black),
      cursorColor: Colors.black,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            //r"\w+@charusat+\.edu+\.in$")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }

        return null;
      },
      onSaved: (String value) {
        user.mail = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(fontSize: 19, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 5 || value.length > 20) {
          return 'Password must be betweem 5 and 20 characters';
        }

        return null;
      },
      onSaved: (String value) {
        user.password = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(fontSize: 19, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('postsignup');
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 190, 32, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              
                  SizedBox(height: 29),
                  _buildEmailField(),
                  _buildPasswordField(),
                  _buildConfirmPasswordField(),
                  SizedBox(height: 30),
                  Container(
                    height: 40.0,
                    width: 300,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.deepPurpleAccent,
                      color: Colors.deepPurple,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () => _submitForm(),
                        child: Center(
                          child: Text(
                            'Signup',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {});
  }
}
