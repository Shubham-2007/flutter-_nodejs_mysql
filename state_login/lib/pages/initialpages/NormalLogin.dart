import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/models/users.dart';
import 'package:state_login/notifiers/auth_notifier.dart';
import 'package:state_login/pages/initialPages/signup.dart';

class NLogin extends StatefulWidget {
  @override
  _NLoginState createState() => _NLoginState();
}

class _NLoginState extends State<NLogin> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  String _errorMessage;
  User _user = User();
  AuthNotifier authNotifier;

  void _submitForm(){
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    login(_user, authNotifier);
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
        _user.mail = value;
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
        _user.password = value;
      },
    );
  }


  Widget build(BuildContext context) {
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
              padding: EdgeInsets.fromLTRB(32, 76, 32, 0),
              child: Column(
                children: <Widget>[
                  Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 20.0, 110.0, 0.0),
                                child: Text('Login',
                                    style: TextStyle(
                                        fontSize: 80.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    200.0, 20.0, 100.0, 0.0),
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
                 
                  _buildEmailField(),
                  _buildPasswordField(),
                  
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
                            'Login',
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
                  ButtonTheme(
                    minWidth: 200,
                    child: FlatButton(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Not Have Account? Switch to Signup',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                         Navigator.of(context).push(
                            MaterialPageRoute(builder: (contex) => Signup()));
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
