import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/layout/home_layout.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

class ResultScreen extends StatelessWidget {
   const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: (){
                    navigateAndFinish(context, const HomeLayout());
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: blackColor,
                  ),
              ),


              SizedBox(height: 15.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'correct',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: blackColor,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 28.sp,
                  ),
                  SizedBox(width: 5.w,),

                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: blackColor,
                    ),
                  ),
                  SizedBox(width: 5.w,),

                  Text(
                    '3',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: blackColor,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20.h,),



              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'wrong',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: blackColor,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    'x',
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 10.w,),

                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: blackColor,
                    ),
                  ),
                  SizedBox(width: 10.w,),

                  Text(
                    '3',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: blackColor,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20.h,),

              Center(
                child: defaultButton(
                    backgroundColor: yellowColor,
                    onPressed: (){
                      navigateAndFinish(context, const HomeLayout());
                    },
                    widget: const Text(
                      'Learn New Signs'
                    ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
