import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/modules/edit_profile_screen.dart';
import 'package:sign_lang_app/modules/sign_in_screen.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:sign_lang_app/shared/network/local/cache_helper.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';
import '../cubit/sates.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<bool> isShow = [false, false, false];





  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => AppCubit()..getUser(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          var userModel = cubit.userModel;

          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                        CircleAvatar(
                          radius: 45.r,
                          backgroundColor: Colors.transparent,

                            child: CircleAvatar(
                              radius: 50.r,
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
                              ),
                            )

                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Column(

                            children: [
                              Container(
                                padding: const EdgeInsetsDirectional.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: lightGreyColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'username',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: blackColor,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isShow[0] = !isShow[0];
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isShow[0])
                                      Text(
                                        '${userModel.username}',
                                        style: TextStyle(
                                          color: blackColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Container(
                                padding: const EdgeInsetsDirectional.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: lightGreyColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: blackColor,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isShow[1] = !isShow[1];
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isShow[1])
                                      Text(
                                        '${userModel.email}',
                                        style: TextStyle(
                                          color: blackColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Container(
                                padding: const EdgeInsetsDirectional.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: lightGreyColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Age',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: blackColor,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isShow[2] = !isShow[2];
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isShow[2])
                                      Text(
                                        '${userModel.age}',
                                        style: TextStyle(
                                          color: blackColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25.h,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  defaultButton(
                                      backgroundColor: redColor,
                                      onPressed: (){
                                        cubit.signOut().then((value){
                                          navigateAndFinish(context, SignInScreen());
                                        }).catchError((error){
                                          print('error in logout ?????? ${error.toString()}');
                                        });

                                      },
                                      widget: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Logout',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          SizedBox(width: 15.w,),
                                          const Icon(
                                            Icons.logout_outlined,
                                          ),
                                        ],
                                      )
                                  ),
                                  defaultButton(
                                      backgroundColor: yellowColor,
                                      onPressed: (){
                                        navigate(context, const EditProfileScreen());
                                      },
                                      widget: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          SizedBox(width: 15.w,),
                                          const Icon(
                                            Icons.edit,
                                          ),
                                        ],
                                      ),
                                  ),
                                ],
                              ),

                            ],
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
