
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego/services/prefs_service.dart';

import '../pages/signin_page.dart';

class AuthService{
  static final _auth = FirebaseAuth.instance;

  //Authication sign in
  static Future<User?>signInUser(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    } catch (error) {
      print('Sign In ***** => $error');
      return null;
    }
  }

//Authication sign up
  static Future<User?>signUpUser(BuildContext context, String name, String email, String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return user;
    }catch(error){
      print('Sign UP ***** => $error');
      return null;
    }
  }


  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Prefs.removeUserId().then((value) {
      Navigator.pushReplacementNamed(context, SignIn.id);
    });
  }
}