import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthNotifier with ChangeNotifier {
  String _userid;
  GoogleSignInAccount _guser;
  
  String get user => _userid;

  void setUser(String user) {
    _userid = user;
    notifyListeners();
  }

  GoogleSignInAccount get guser => _guser;

  void setGUser(GoogleSignInAccount guser){
    _guser = guser;
    notifyListeners();
  }
}
