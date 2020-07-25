// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:state_login/apiprovider/user_api.dart';
// import 'package:state_login/models/users.dart';
// import 'package:state_login/notifiers/auth_notifier.dart';

// enum AuthMode { Signup, Login }

// class Login extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _LoginState();
//   }
// }

// class _LoginState extends State<Login> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _passwordController = new TextEditingController();
//   AuthMode _authMode = AuthMode.Login;
//   String _errorMessage;
//   String _dropDownValue;
//   User _user = User();

//   @override
//   void initState() {
//     AuthNotifier authNotifier =
//         Provider.of<AuthNotifier>(context, listen: false);
//     initializeCurrentUser(authNotifier);
//     super.initState();
//   }

//   void _submitForm() {
//     if (!_formKey.currentState.validate()) {
//       return;
//     }

//     _formKey.currentState.save();

//     AuthNotifier authNotifier =
//         Provider.of<AuthNotifier>(context, listen: false);

//     if (_authMode == AuthMode.Login) {
//       login(_user, authNotifier);
//     } else {
//       // _showVerifyEmailSentDialog();
//       signup(_user, authNotifier);
//     }
//   }

//   Widget _buildDisplayNameField() {
//     return Column(
//       children: <Widget>[
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: "Display Name",
//             labelStyle: TextStyle(color: Colors.purple),
//           ),
//           keyboardType: TextInputType.text,
//           style: TextStyle(fontSize: 19, color: Colors.white),
//           cursorColor: Colors.white,
//           validator: (String value) {
//             if (value.isEmpty) {
//               return 'Display Name is required';
//             }

//             if (value.length < 5 || value.length > 12) {
//               return 'Display Name must be betweem 5 and 12 characters';
//             }

//             return null;
//           },
//           onSaved: (String value) {
//             _user.name = value;
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: "Phone No",
//             labelStyle: TextStyle(color: Colors.purple),
//           ),
//           keyboardType: TextInputType.number,
//           style: TextStyle(fontSize: 19, color: Colors.white),
//           cursorColor: Colors.white,
//           validator: (String value) {
//             if (value.isEmpty) {
//               return 'Phoneno is required';
//             }

//             if (value.length < 10 || value.length > 10) {
//               return 'Phone no length should be 10';
//             }

//             return null;
//           },
//           onSaved: (String value) {
//             _user.number = value;
//           },
//         ),
//       ],
//     );
//   }

//   // Widget _buildPhoneNumberField() {
//   //   return TextFormField(
//   //     decoration: InputDecoration(
//   //       labelText: "Phone No",

//   //       labelStyle: TextStyle(color: Colors.white54),
//   //     ),
//   //     keyboardType: TextInputType.number,
//   //     style: TextStyle(fontSize: 19, color: Colors.white),
//   //     cursorColor: Colors.white,
//   //     validator: (String value) {
//   //       if (value.isEmpty) {
//   //         return 'Phoneno is required';
//   //       }

//   //       if (value.length < 10 || value.length > 10) {
//   //         return 'Phone no length should be 10';
//   //       }

//   //       return null;
//   //     },
//   //     onSaved: (String value) {
//   //       _user.number = value;
//   //     },
//   //   );
//   // }

//   Widget _buildEmailField() {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: "Email",
//         hintText: 'email',
//         labelStyle: TextStyle(color: Colors.purple),
//       ),
//       keyboardType: TextInputType.emailAddress,
//       style: TextStyle(fontSize: 19, color: Colors.white),
//       cursorColor: Colors.white,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Email is required';
//         }

//         if (!RegExp(
//                 r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//             //r"\w+@charusat+\.edu+\.in$")
//             .hasMatch(value)) {
//           return 'Please enter a valid email address';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _user.mail = value;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: "Password",
//         labelStyle: TextStyle(color: Colors.purple),
//       ),
//       style: TextStyle(fontSize: 19, color: Colors.purple),
//       cursorColor: Colors.white,
//       obscureText: true,
//       controller: _passwordController,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Password is required';
//         }

//         if (value.length < 5 || value.length > 20) {
//           return 'Password must be betweem 5 and 20 characters';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _user.password = value;
//       },
//     );
//   }

//   Widget _buildConfirmPasswordField() {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: "Confirm Password",
//         labelStyle: TextStyle(color: Colors.purple),
//       ),
//       style: TextStyle(fontSize: 19, color: Colors.white),
//       cursorColor: Colors.white,
//       obscureText: true,
//       validator: (String value) {
//         if (_passwordController.text != value) {
//           return 'Passwords do not match';
//         }

//         return null;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Building login screen");

//     return Scaffold(
//       body: Container(
//         constraints: BoxConstraints.expand(
//           height: MediaQuery.of(context).size.height,
//         ),
//         decoration: BoxDecoration(color: Colors.white),
//         child: Form(
//           autovalidate: true,
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(32, 76, 32, 0),
//               child: Column(
//                 children: <Widget>[
//                   _authMode == AuthMode.Signup
//                       ? Container(
//                           child: Stack(
//                             children: <Widget>[
//                               Container(
//                                 padding:
//                                     EdgeInsets.fromLTRB(0.0, 20.0, 110.0, 0.0),
//                                 child: Text('Signup',
//                                     style: TextStyle(
//                                         fontSize: 60.0,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               Container(
//                                 padding:
//                                     EdgeInsets.fromLTRB(220.0, 10.0, 80.0, 0.0),
//                                 child: Text('.',
//                                     style: TextStyle(
//                                         fontSize: 80.0,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.deepPurple)),
//                               ),
//                             ],
//                           ),
//                         )
//                       : Container(
//                           child: Stack(
//                             children: <Widget>[
//                               Container(
//                                 padding:
//                                     EdgeInsets.fromLTRB(0.0, 20.0, 110.0, 0.0),
//                                 child: Text('Login',
//                                     style: TextStyle(
//                                         fontSize: 60.0,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.fromLTRB(
//                                     200.0, 20.0, 100.0, 0.0),
//                                 child: Text('.',
//                                     style: TextStyle(
//                                         fontSize: 80.0,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.deepPurple)),
//                               ),
//                             ],
//                           ),
//                         ),
//                   SizedBox(height: 29),
//                   _authMode == AuthMode.Signup
//                       ? _buildDisplayNameField()
//                       : Container(),
//                   _buildEmailField(),
//                   _buildPasswordField(),
//                   _authMode == AuthMode.Signup
//                       ? _buildConfirmPasswordField()
//                       : Container(),
//                   SizedBox(height: 30),
//                   ButtonTheme(
//                     minWidth: 380,
//                     child: RaisedButton(
//                       padding: EdgeInsets.all(10.0),
//                       onPressed: () => _submitForm(),
//                       child: Text(
//                         _authMode == AuthMode.Login ? 'Login' : 'Signup',
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ButtonTheme(
//                     minWidth: 200,
//                     child: FlatButton(
//                       padding: EdgeInsets.all(10.0),
//                       child: Text(
//                         'Not Have Account? Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
//                         style: TextStyle(fontSize: 13, color: Colors.purple),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _authMode = _authMode == AuthMode.Login
//                               ? AuthMode.Signup
//                               : AuthMode.Login;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // void _showVerifyEmailSentDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       // return object of type Dialog
//   //       return AlertDialog(
//   //         title: new Text("Verify your account"),
//   //         content:
//   //             new Text("Link to verify account has been sent to your email"),
//   //         actions: <Widget>[
//   //           new FlatButton(
//   //             child: new Text("Dismiss"),
//   //             onPressed: () {
//   //               _changeFormToLogin();
//   //               Navigator.of(context).pop();
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   void _changeFormToLogin() {
//     _formKey.currentState.reset();
//     _errorMessage = "";
//     setState(() {
//       _authMode = AuthMode.Login;
//     });
//   }
// }
