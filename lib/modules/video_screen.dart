import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  String word;
  String videoUrl;
   VideoScreen({super.key, required this.word, required this.videoUrl});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {



  late VideoPlayerController _videoPlayerController ;
  late ChewieController _chewieController ;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
     // autoPlay: true,
      aspectRatio: 18/17,
      allowFullScreen: true,
      autoInitialize: true,
      showControls: true,
      showOptions: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: whitColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: blackColor,
                        ),
                      ),


                      Text(
                        widget.word,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),

                      IconButton(
                        onPressed: (){
                          cubit.addReviewList(
                             // categoryName: categoryName,
                              //categoryImage: categoryImage,
                              videoWord: widget.word,
                              videoUrl: widget.videoUrl,
                          );
                        },
                        icon: Icon(
                          Icons.save_as_outlined,
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.5,
                      child: AspectRatio(
                        aspectRatio: 18/17,
                        child: Chewie(
                          controller: _chewieController,
                        ),
                      )
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
