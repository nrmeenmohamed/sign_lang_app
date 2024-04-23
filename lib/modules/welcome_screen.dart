import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/modules/sign_in_screen.dart';
import 'package:sign_lang_app/modules/signup_screen.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

import '../shared/componenets/componenets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  image:  AssetImage('assets/images/welcome.png'),
              ),
              SizedBox(height: 15.h,),

              Row(
                children: [
                  Text(
                    'Welcome to ',
                    style: TextStyle(
                      fontSize: 17.sp,
                    ),
                  ),
                  Text(
                    'SignLearn ',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFda4663),
                    ),
                  ),
                  Text(
                    '! Learn sign',
                    style: TextStyle(
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),

              Text(
                'language effortlessly with our interactive platform. Get ready to dive into the world of sign language and communicate with confidence',
                style: TextStyle(
                  fontSize: 17.sp,
                ),

              ),
              SizedBox(height: 30.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  defaultButton(
                      backgroundColor: yellowColor,
                      onPressed: (){
                        navigateAndFinish(context, SignInScreen());
                      },
                      widget: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                  ),
                  //SizedBox(width: 40.w,),

                  defaultButton(
                    backgroundColor: blueColor,
                    onPressed: (){
                      navigateAndFinish(context, SignupScreen());
                    },
                    widget: Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
