import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import '../shared/styles/colors.dart';

class EditProfileScreen extends StatefulWidget {
   const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
   var usernameController = TextEditingController();

   var emailController = TextEditingController();

   var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUser(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state) {

          AppCubit cubit = AppCubit.get(context);

          var userModel = cubit.userModel;

          usernameController.text = userModel.username!;
          emailController.text = userModel.email!;
          ageController.text = userModel.age!;


          return Scaffold(
            backgroundColor: whitColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.3,
                          color: const Color(0xFFcddbdc),
                        ),
                        Image(
                          image: const AssetImage('assets/images/profile_back.png'),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.3,
                          fit: BoxFit.fill,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                                radius: 45.r,
                                backgroundColor: whitColor,
                                child: cubit.userModel.image != null
                                    ? ClipOval(
                                  child: Image(
                                    image: NetworkImage('${cubit.userModel.image}'),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Icon(
                                  Icons.person,
                                  size: 40.sp,
                                  color: Colors.grey,
                                )
                            ),
                            CircleAvatar(
                              radius: 17.r,
                              backgroundColor: yellowColor,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    SmartDialog.show(builder: (context) {
                                      return Container(
                                        padding: const EdgeInsetsDirectional.all(25),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          color: whitColor,
                                          border: Border.all(
                                            color: blackColor,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap:()async{
                                                await cubit.uploadImage(isCamera: false);

                                              },
                                              child: Container(
                                                padding: const EdgeInsetsDirectional.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  color: yellowColor,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.image,
                                                      size: 45.sp,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(height: 5.h,),
                                                    Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                        fontSize: 25.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20.w,),
                                            GestureDetector(
                                              onTap:()async{
                                                await cubit.uploadImage(isCamera: true);
                                              },
                                              child: Container(
                                                padding: const EdgeInsetsDirectional.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  color: yellowColor,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      size: 45.sp,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(height: 5.h,),
                                                    Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                        fontSize: 25.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    });
                                  });
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 17.sp,
                            ),
                          ),
                          SizedBox(height: 5.h,),

                          Container(
                            color:Colors.white,
                            child: TextFormField(
                              onFieldSubmitted: (value){
                                cubit.updateUser(
                                    email: emailController.text,
                                    userName: usernameController.text,
                                    age: ageController.text,
                                );
                              },
                              controller: emailController,
                              decoration: const InputDecoration(
                                 border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),


                          Text(
                            'username',
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 17.sp,
                            ),
                          ),
                          SizedBox(height: 5.h,),

                          Container(
                            color:Colors.white,
                            child: TextFormField(
                              controller: usernameController,
                              onFieldSubmitted: (value){
                                cubit.updateUser(
                                  email: emailController.text,
                                  userName: usernameController.text,
                                  age: ageController.text,
                                );
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),


                          Text(
                            'Age',
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 17.sp,
                            ),
                          ),
                          SizedBox(height: 5.h,),

                          Container(
                            color:Colors.white,
                            child: TextFormField(
                              controller: ageController,
                              onFieldSubmitted: (value){
                                cubit.updateUser(
                                  email: emailController.text,
                                  userName: usernameController.text,
                                  age: ageController.text,
                                );
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),

                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: defaultButton(
                                backgroundColor: yellowColor,
                                onPressed: (){
                                  cubit.updateUser(
                                      email: emailController.text,
                                      userName: usernameController.text,
                                      age: ageController.text,
                                  );
                                },
                                widget: Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

