import 'package:flutter/material.dart';
import 'package:medico/screen/login.dart';
import 'package:medico/screen/user_login.dart';
import 'package:medico/screen/user_signup.dart';
import 'package:medico/widget/custom_scaffold.dart';
import 'package:medico/widget/welcomebutton.dart';

class user_welcome_page extends StatelessWidget {
  const user_welcome_page({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return customscaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100.0,
                        height: 100.0,
                      ),
                      const SizedBox(
                          height: 10
                      ),
                   RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      TextSpan(
                          text: 'Welcome Back User ! \n',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text:
                          '\n Enter Personal Detail to Your  account ',
                          style: TextStyle(
                            fontSize: 20,
                          ))
                    ]),
                  ),]
                ),
              )),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: welcomebutton(
                      buttonText: 'Sign Up ',
                      onTap: usersignup(),
                      color: Colors.transparent,
                      textColors: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: welcomebutton(
                        buttonText: 'Login',
                        onTap: login(),
                        color: Colors.white,
                      textColors: Colors.lightBlueAccent,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
