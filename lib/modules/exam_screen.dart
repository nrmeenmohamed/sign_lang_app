import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:video_player/video_player.dart';
import '../layout/home_layout.dart';
import '../shared/styles/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  var pageController = PageController();
  bool isLast = false;

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;


  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getReviewListFromFireBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            backgroundColor: whitColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        children: List.generate(
                          cubit.reviews.length,
                              (index) {
                            var listReviewIndex = cubit.reviews[index];

                            _videoPlayerController =
                                VideoPlayerController.network('${listReviewIndex.videoUrl}');
                            _chewieController = ChewieController(
                              videoPlayerController: _videoPlayerController,
                              aspectRatio: 18 / 17,
                              allowFullScreen: true,
                              autoInitialize: true,
                              showControls: true,
                              showOptions: true,
                            );

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'think what is this sign ?',
                                      style: TextStyle(
                                        color: blackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    SizedBox(width: 15.w,),
                                    Image(
                                        image: const AssetImage('assets/images/emogy.png'),
                                      width: MediaQuery.of(context).size.width*0.15,
                                      height: MediaQuery.of(context).size.height*0.15,

                                    ),

                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.5 ,
                                  child: AspectRatio(
                                    aspectRatio: 18 / 17,
                                    child: Chewie(
                                      controller: _chewieController,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'this sign is',
                                      style: TextStyle(
                                        color: blackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Text(
                                      '${listReviewIndex.videoWord}',
                                      style: TextStyle(
                                        color: redColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.sp,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ).animate().fade(delay: 20.seconds),

                                  ],
                                ),
                                const Spacer(),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: defaultButton(
                                    backgroundColor: yellowColor,
                                    onPressed: () {
                                      if(index < cubit.reviews.length - 1){
                                        pageController.nextPage(
                                          duration: const Duration(milliseconds: 20),
                                          curve: Curves.linear,
                                        );
                                      }
                                      else{
                                        navigateAndFinish(context, const HomeLayout());
                                      }
                                    },
                                    widget: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Next',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 5.w,),
                                        Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 5.w,),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5.w,),
                                        Text(
                                          '${cubit.reviews.length}',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            );
                          },
                        ),
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
