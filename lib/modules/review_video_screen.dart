import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';
import 'package:video_player/video_player.dart';

class ReviewVideoScreen extends StatefulWidget {
  String word;
  String videoUrl;
  ReviewVideoScreen({super.key, required this.word, required this.videoUrl});

  @override
  State<ReviewVideoScreen> createState() => _ReviewVideoScreenState();
}

class _ReviewVideoScreenState extends State<ReviewVideoScreen> {



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
        return Scaffold(
          backgroundColor: whitColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
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

                        SizedBox(width:70.w,),
                      Text(
                        widget.word,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
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
