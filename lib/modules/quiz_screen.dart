import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

import 'exam_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whitColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let\'s Take Exam To Check Your Learning.',
              style: TextStyle(
                fontSize: 18.sp,
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h,),

            const Image(
              image: AssetImage('assets/images/exam.png'),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: defaultButton(
                  backgroundColor: yellowColor,
                  onPressed: (){
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Take Exam',
                      desc: 'Are you ready ?',
                      btnOkText: 'Yes',
                      btnCancelText: 'No',
                      btnOkColor: yellowColor,
                      btnCancelColor: redColor,
                      btnCancelOnPress: () {
                      },
                      btnOkOnPress: () {
                        navigate(context, const ExamScreen());
                      },
                    ).show();
                  },
                  widget: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
