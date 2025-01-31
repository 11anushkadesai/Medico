import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medico/screen/user_signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medico/theme/theme.dart';
import 'package:medico/widget/custom_scaffold.dart';
import 'package:flutter/src/widgets/gesture_detector.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  final _formkey =GlobalKey<FormState>();


  String email="" ;
  TextEditingController emailcontroller= new TextEditingController();

  _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
      _showSuccessSnackbar('Password reset email sent. Please check your inbox.');
    } catch (e) {
      _showErrorSnackbar('Error: ${e.toString()}');
    }
  }
  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
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
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                          height: 40
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
                          height: 40
                      ),

                      GestureDetector(
                        onTap: (){
                          if (_formkey.currentState!.validate()) {
                            _resetPassword();
                          }
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
                                  "Send Email",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),)
                            )
                        ),
                      ),
                      const SizedBox(
                          height: 30
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

