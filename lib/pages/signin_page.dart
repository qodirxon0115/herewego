import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signup_page.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

import '../services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const String id = "signin_page";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doLogin(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  _getFirebaseUser(User? firebaseUser) async{
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast("Check your email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email"
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "Password"
              ),
            ),
             const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 45,
              color: Colors.deepOrange,
              child: TextButton(
                onPressed: ()=>_doLogin(),
                child: const Text("Sign In",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, SignUp.id);
                  },
                  child: const Text("Sign Up", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
