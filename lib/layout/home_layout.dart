import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../modules/profile_screen.dart';

class HomeLayout extends StatefulWidget {
   const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUser(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
         var cubit = AppCubit.get(context);

          return Scaffold(
            backgroundColor: whitColor,
            key: scaffoldKey,
            appBar: AppBar(
              titleSpacing: 15,
              backgroundColor: whitColor,
              title: Text(
                'SignLearn',
                style: TextStyle(
                  color: blackColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    cubit.setMode();
                  },
                  icon: Icon(
                    Icons.dark_mode_rounded,
                    color: blackColor,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    navigate(context, ProfileScreen());
                  },
                  icon: Icon(
                    Icons.person,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 5,
                start: 10,
                end: 10,
              ),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                ),

                child: Stack(
                  children: [
                    Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            blueColor,
                            redColor,
                            yellowColor,
                          ],
                        ),
                      ),
                    ),
                    StylishBottomBar(
                      option: AnimatedBarOptions(
                        // iconSize: 32,
                        barAnimation: BarAnimation.fade,
                        iconStyle: IconStyle.animated,

                      ),
                      items: cubit.bottomItems,
                      backgroundColor: Colors.transparent,

                      elevation: 80,
                      hasNotch: true,
                      currentIndex: cubit.currentIndex,
                      onTap: (index) {
                       cubit.changeNaveItem(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
            body:cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }

}
