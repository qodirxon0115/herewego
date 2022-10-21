import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/auth_service.dart';

import '../services/prefs_service.dart';
import '../services/utils_service.dart';
import 'home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String id = "signup_page";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  _doSignup(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String name = nameController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty)return;

    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });
  }

  _getFirebaseUser(dynamic firebaseUser) async{
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast("Check your informations");
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
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: "FullName"
              ),
            ),
            const SizedBox(height: 10,),
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
                onPressed:()=> _doSignup(),
                child: const Text("Sign Up",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Already have an account?"),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, SignIn.id);
                  },
                  child: const Text("Sign In", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
