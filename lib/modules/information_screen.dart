import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  List<bool> isShown = [false, false, false, false, false, false, false];
  bool g = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is Sign Language ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: blueColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Sign language is manual communication commonly used by people who are deaf. Sign language is not universal; people who are deaf from different countries speak different sign languages. The gestures or symbols in sign language are organized in a linguistic way. Each individual gesture is called a sign. Each sign has three distinct parts: the hand shape, the position of the hands, and the movement of the hands. It is based on visual cues through the hands, eyes, face, mouth, and body.',
                style: TextStyle(
                  fontSize: 17.sp,
                  height: 1.5.h,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Our Tips for Communicating with Deaf People',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: yellowColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: lightGreyColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1- Always face a deaf person',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShown[0] = !isShown[0];
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (isShown[0])
                      Text(
                        'Make eye contact and keep it while you are talking. Try not to look away or cover your mouth as many deaf people rely on lip reading to help them understand you.',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          height: 1.5.h,
                          color: blackColor,
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: lightGreyColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2- Check noise and lighting',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShown[1] = !isShown[1];
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (isShown[1])
                      Text(
                        'Turn off or move away from background noise. Make sure your face is not \in shadow and there are no strong lights or sunshine in their eyes.',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          height: 1.5.h,
                          color: blackColor,
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: lightGreyColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '3- Keep your distance',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShown[2] = !isShown[2];
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (isShown[2])
                      Text(
                        'Stand a metre or two away from the deaf person. This is important for hearing- aid users, lip-readers and signers.',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          height: 1.5.h,
                          color: blackColor,
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: lightGreyColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '4- Speak clearly, slowly, and steadily',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShown[3] = !isShown[3];
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (isShown[3])
                      Text(
                        'Don\'t mumble, shout or exaggerate — it distorts your lip patterns.',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          height: 1.5.h,
                          color: blackColor,
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: lightGreyColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '5- Take turns',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShown[4] = !isShown[4];
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (isShown[4])
                      Text(
                        'If there is more than one person in a conversation take turns to talk.',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          height: 1.5.h,
                          color: blackColor,
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: lightGreyColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '6- Repeat and re-phrase if necessary',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShown[5] = !isShown[5];
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (isShown[5])
                      Text(
                        'Trying to say the same thing in a different way might help.',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          height: 1.5.h,
                          color: blackColor,
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: lightGreyColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '7- Write it down',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isShown[6] = !isShown[6];
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (isShown[6])
                      Text(
                        'Don\'t be afraid to write or draw to help understanding. And arguably one of the most important points to remember \is to keep trying — even if a deaf person does not understand what you\'re saying the first few times. So many of our partners have told us that when someone says \'oh, don\'t worry. It doesn\'t matter\' it feels like they mean \'you don\'t matter.\' Even if it takes four or five times of rephrasing or even writing it down, don\'t give up.',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          height: 1.5.h,
                          color: blackColor,
                        ),
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),





            ],
          ),
        ),
      ),
    );
  }
}
