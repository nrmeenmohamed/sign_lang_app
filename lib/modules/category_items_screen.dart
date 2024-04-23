import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/modules/video_screen.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

class CategoryItemsScreen extends StatelessWidget {
  String categoryName;
  String categoryId;

  CategoryItemsScreen({super.key, required this.categoryName, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getVideoFromFireBase(id: categoryId),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            backgroundColor: whitColor,
            appBar: AppBar(
              backgroundColor: blueColor,
              title: Text(
                categoryName,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 3,
                ) ,
                itemBuilder: (context, index){
                  var video = cubit.videos[index];
                  return categoryItems(context,
                    word: video.name!,
                    onTap: (){
                    navigate(context, VideoScreen(
                      word: video.name!,
                      videoUrl: video.link!,
                    ));
                    }
                  );
                }, itemCount: cubit.videos.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

