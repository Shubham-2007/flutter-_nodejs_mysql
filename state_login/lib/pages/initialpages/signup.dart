import 'package:flutter/material.dart';
import 'package:state_login/models/users.dart';
import 'package:state_login/notifiers/auth_notifier.dart';
import 'package:state_login/pages/initialPages/PostSignUp.dart';

final User user = User();

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();

  AuthNotifier authNotifier;

  bool _submitForm() {
    if (!_formKey.currentState.validate()) {
      return false;
    }

    _formKey.currentState.save();
    return true;
  }

  Widget _buildDisplayNameField() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: "Display Name",
            labelStyle: TextStyle(color: Colors.grey),
          ),
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 19, color: Colors.black),
          cursorColor: Colors.black,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Display Name is required';
            }

            if (value.length < 5 || value.length > 12) {
              return 'Display Name must be betweem 5 and 12 characters';
            }

            return null;
          },
          onChanged: (String value) {
            user.name = value;
            user.last = value;
            print(user.name);
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Phone No",
            labelStyle: TextStyle(color: Colors.grey),
          ),
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 19, color: Colors.black),
          cursorColor: Colors.black,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Phoneno is required';
            }

            if (value.length < 10 || value.length > 10) {
              return 'Phone no length should be 10';
            }

            return null;
          },
          onChanged: (String value) {
            user.number = value;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('signupasfgadafhadh');
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
              padding: EdgeInsets.fromLTRB(32, 180, 32, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 110.0, 0.0),
                          child: Text('Signup',
                              style: TextStyle(
                                  fontSize: 69.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(220.0, 10.0, 80.0, 0.0),
                          child: Text('.',
                              style: TextStyle(
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 29),
                  _buildDisplayNameField(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.arrow_forward),
          onPressed: () {
            if (_submitForm()) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (contex) => PostSignup()));
            }
          }),
    );
  }
}
