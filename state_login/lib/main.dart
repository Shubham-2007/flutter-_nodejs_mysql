import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/homepage.dart';
import 'package:state_login/pages/initialPages/StartingPage.dart';
import 'package:state_login/pages/login_2.dart';
import 'models/users.dart';
import 'notifiers/auth_notifier.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) {
          return AuthNotifier();
        },
      ),
    ],
    child: TaskApp(),
  ));
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            elevation: 5,
            color: ThemeData.light().canvasColor,
          )),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null || notifier.guser!=null
              ? Task(
                  id: notifier.user,
                )
              : StartingPage();
        },
      ),
    );
  }
}
