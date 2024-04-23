import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/modules/sign_in_screen.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';
import 'package:sign_lang_app/shared/network/local/cache_helper.dart';

import '../layout/home_layout.dart';
import '../shared/componenets/componenets.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {


        if(state is AppCreateUserSuccessState){
          CacheHelper.saveDate(
            key: 'uId',
            value: state.uId,
          ).then((value){
            print("saved id in cache helper ............................................");
            navigateAndFinish(context, const HomeLayout());
          }).catchError((error){
            print("???????error id in cache helper ${error.toString()} ???????????");

          });
        }




        if(state is AppCreateUserSuccessState){
          navigateAndFinish(context, const HomeLayout());
        }
      },
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/1.PNG'),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Create account',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              defaultFormField(
                                controller: usernameController,
                                labelText: 'Username',
                                keyboardType: TextInputType.text,
                                prefixIcon: Icons.person,
                                validator:(value)
                                {
                                  if(value == null || value.isEmpty){
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.h,),
                              defaultFormField(
                                controller: ageController,
                                labelText: 'Age',
                                keyboardType: TextInputType.text,
                                prefixIcon: Icons.account_box_rounded,
                                validator:(value)
                                {
                                  if(value == null || value.isEmpty){
                                    return 'Please enter your age';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),

                              defaultFormField(
                                controller: emailController,
                                labelText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                                validator: (value)
                                {
                                  if(value == null || value.isEmpty){
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(
                                height: 15.h,
                              ),
                              defaultFormField(
                                obscureText: AppCubit.get(context).passwordShown,
                                controller: passwordController,
                                labelText: 'Password',
                                keyboardType: TextInputType.text,
                                prefixIcon: Icons.lock,
                                suffixIcon: AppCubit.get(context).passwordShown ? Icons.visibility_off : Icons.visibility,
                                onPressedSuffixIcon: (){
                                  AppCubit.get(context).showPassword();
                                },
                                validator:(value)
                                {
                                  if(value == null || value.isEmpty){
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),


                              ConditionalBuilder(
                                condition: state is! AppSignupLoadingState,
                                builder: (BuildContext context) {
                                  return  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF0063ff),
                                          Color(0xFF0098e7),
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                    child:  defaultButton(
                                      backgroundColor: Colors.transparent,
                                      width: double.infinity,
                                      height: 55.h,
                                      onPressed: () {
                                        if (formKey.currentState != null && formKey.currentState!.validate()) {
                                          AppCubit.get(context).signup(context,
                                            email: emailController.text,
                                            password: passwordController.text.trim(),
                                            userName: usernameController.text,
                                            age: ageController.text,
                                          );
                                          print('Signup Successful');
                                        } else {
                                          print('Invalid Form');
                                        }
                                      },
                                      widget: Text(
                                        'Signup',
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                        ),
                                      ),
                                    ),

                                  );
                                },
                                fallback: (BuildContext context) {
                                  return const Center(child: CircularProgressIndicator());
                                },
                              ),

                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account'),
                                  TextButton(
                                    onPressed: () {
                                      navigateAndFinish(context, SignInScreen());
                                    },
                                    child: Text(
                                        'Login',
                                      style: TextStyle(
                                        color: blueColor,
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
            ),
          ),
        );
      },
    );
  }
}





















//
// Align(
// alignment: Alignment.topCenter,
// child: Image(
// image: AssetImage('assets/images/signup.png'),
// //image: NetworkImage('https://storyset.com/illustration/sign-up/bro#C53F3FFF&hide=&hide=complete'),
// // width: double.infinity,
// height:MediaQuery.of(context).size.height*0.4,
// //   fit: BoxFit.fill,
// ),
// ),
// Align(
// alignment: Alignment.bottomCenter,
// child: CustomPaint(
// size: Size(
// double.infinity,
// MediaQuery.of(context).size.height*0.6,
// ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(15.0),
// child: Column(
// mainAxisSize: MainAxisSize.min,
// //mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Material(
// elevation: 20,
// borderRadius: BorderRadius.circular(10.r),
// child: defaultFormField(
// labelText: 'Email',
// keyboardType: TextInputType.emailAddress,
// prefixIcon: Icons.email,
// ),
// ),
//
// SizedBox(height: 15.h,),
// Material(
// elevation: 20,
// borderRadius: BorderRadius.circular(10.r),
// child: defaultFormField(
// labelText: 'Username',
// keyboardType: TextInputType.text,
// prefixIcon: Icons.person,
// ),
// ),
//
// SizedBox(height: 15.h,),
// Material(
// elevation: 20,
// borderRadius: BorderRadius.circular(10.r),
// child: defaultFormField(
// labelText: 'Password',
// keyboardType: TextInputType.text,
// prefixIcon: Icons.lock,
// suffixIcon: Icons.visibility_off,
// ),
// ),
// SizedBox(height: 15.h,),
//
//
//
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10.r),
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: [
// Color(0xFF0063ff),
// Color(0xFF0098e7),
// Colors.white,
// ],
// // colors: [
// //   Color(0xFF030506),
// //   Color(0xFF243139),
// //   Colors.white,
// // ],
// ),
// ),
// child: defaultButton(
// backgroundColor:Colors.transparent,
// width: double.infinity,
// height: 55.h,
// onPressed: (){},
// widget: Text(
// 'Signup',
// style: TextStyle(
// fontSize: 17.sp,
// ),
// ),
// ),
// ),
// SizedBox(height: 15.h,),
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10.r),
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// // colors: [
// //   Color(0xFF0063ff),
// //   Color(0xFF0098e7),
// //   Colors.white,
// // ],
// colors: [
// Color(0xFF030506),
// Color(0xFF243139),
// Colors.white,
// ],
// ),
// ),
// child: defaultButton(
// backgroundColor: Colors.transparent,
// width: double.infinity,
// height: 55.h,
// onPressed: (){},
// widget: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text(
// 'Signup',
// style: TextStyle(
// fontSize: 17.sp,
// ),
// ),
// SizedBox(width: 10.w,),
// Image(
// image: AssetImage('assets/images/google.png'),
// width: 25.w,
// height: 25.h,
// ),
// ],
// ),
// ),
// ),
// //SizedBox(height: 15.h,),
//
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(
// 'Already have an account'
// ),
// TextButton(
// onPressed: (){},
// child: Text(
// 'Login'
// ),
// ),
// ],
// ),
//
//
//
//
//
//
//
//
//
// ],
// ),
// ),


