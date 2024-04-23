import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/modules/review_video_screen.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

class ReviewListScreen extends StatelessWidget {
   const ReviewListScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => AppCubit()..getReviewListFromFireBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: whitColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ConditionalBuilder(
                  condition: cubit.reviews.length > 0 ,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              var reviewsList = cubit.reviews[index];
                              return GestureDetector(
                                onTap: (){
                                  navigate(context, ReviewVideoScreen(
                                    word: reviewsList.videoWord!,
                                    videoUrl: reviewsList.videoUrl!,
                                  ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: blackColor,
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      reviewsList.videoWord!,
                                      style: TextStyle(
                                        color: blackColor,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.rate_review,
                                      color: blueColor,
                                    ),
                                    trailing: IconButton(
                                      onPressed: (){
                                        var id= cubit.reviewListIds[index];
                                        cubit.deleteFromReviewList(id: id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 15.h,),
                            itemCount: cubit.reviews.length,
                          ),
                        ],
                      ),
                    );
                  },
                  fallback: (BuildContext context) {
                    return Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(
                        Icons.menu_book,
                        color: blackColor,
                        size: 45.sp,
                    ),
                    Text(
                    'Study more',
                    style: TextStyle(
                    color: blackColor,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w400,
                    ),
                    ),

                    ],
                    ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
