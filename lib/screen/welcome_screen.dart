import 'package:flutter/material.dart';
import 'package:medico/screen/admin_login.dart';
import 'package:medico/screen/admin_screen.dart';
import 'package:medico/screen/login.dart';
import 'package:medico/screen/user_welcome_screen.dart';
import 'package:medico/widget/custom_scaffold.dart';
import 'package:medico/widget/welcomebutton.dart';
import 'package:flutter/src/material/colors.dart';


class welcomescreen extends StatelessWidget {
  const welcomescreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return customscaffold(
        child: Column(

          children:  [

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
                            text: 'Welcome ! \n',
                            style: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w600,
                            )),
                        TextSpan(
                            text:
                            '\n Easy Medical Solutions ',
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
                        buttonText: 'Admin',
                        onTap: login(),
                        color: Colors.transparent,
                        textColors: Colors.white,

                      ),
                    ),
                    Expanded(
                      child: welcomebutton(
                        buttonText: 'User',

                        onTap: user_welcome_page(),
                        color: Colors.white,
                        textColors: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
