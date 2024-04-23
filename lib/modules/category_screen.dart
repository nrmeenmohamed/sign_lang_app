import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/modules/category_items_screen.dart';
import 'package:sign_lang_app/shared/componenets/componenets.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => AppCubit()..getCategoryFromFirebase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state) {

          AppCubit cubit =  AppCubit.get(context);
          return Scaffold(
            backgroundColor: whitColor,
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Learn',
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 20.h,),

                    ListView.separated(

                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var category = cubit.categories[index];
                        return categoryComponent(context,
                            image: category.image!,
                            text: category.name!,
                            onTap: (){
                              var id = cubit.categoryIds[index];
                              print('ID.. = $id');
                              cubit.getVideoFromFireBase(id: id);
                          navigate(context, CategoryItemsScreen(categoryName: category.name!,categoryId: id,));
                            }
                        );
                      },
                      separatorBuilder: (context, index) =>SizedBox(height: 20.h,),
                      itemCount: cubit.categories.length,
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
