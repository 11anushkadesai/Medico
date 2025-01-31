import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medico/screen/forgot_password.dart';
import 'package:medico/screen/user_homepage.dart';
import 'package:medico/screen/user_signup.dart';
import 'package:medico/sevices/auth.dart';
import 'package:medico/theme/theme.dart';
import 'package:medico/widget/custom_scaffold.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/src/widgets/gesture_detector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userloginpage extends StatefulWidget {
  const userloginpage({super.key});

  @override
  State<userloginpage> createState() => _userloginpageState();
}

class _userloginpageState extends State<userloginpage> {
  final _formloginkey =GlobalKey<FormState>();
  bool rememberpassword = true ;

  String email="" ,password="";
  TextEditingController emailcontroller= new TextEditingController();
  TextEditingController passwordcontroller= new TextEditingController();


  userlogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      // Navigate to the user homepage upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => userhomepage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors
      if (e.code == 'user-not-found') {
        _showErrorSnackbar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showErrorSnackbar('Wrong password provided by user.');
      } else {
        _showErrorSnackbar('Error: ${e.message}');
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', email);
  }



  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return customscaffold(
      child: Column(
        children: [
          Expanded(child: SizedBox(height: 10,),),
          Expanded
            (
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child : SingleChildScrollView(
                child: Form(
                  key: _formloginkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome Back ',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                          height: 10
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        validator: (value)
                        {
                          if(value== null || value.isEmpty)
                          {
                            return 'Please enter Email ';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide:  const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 10
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: true,
                        obscuringCharacter: '*',

                        validator: (value)
                        {
                          if(value== null || value.isEmpty)
                          {
                            return 'Please enter Password ';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide:  const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 10
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpassword()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 10
                      ),

                      GestureDetector(
                        onTap: (){
                          userlogin();
                          },
                          child: Container(
                                   width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: Text(
                                    "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),)
                              )
                          ),
                      ),

                      const SizedBox(
                          height: 20
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont\'t have an account?',style: TextStyle(
                            color: Colors.black45,
                          ),),
                          GestureDetector(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (e) => const usersignup()),);
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
