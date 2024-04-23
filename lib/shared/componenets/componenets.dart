import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';

void navigate(context,Widget screen)=>Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => screen,
  ),
);


void navigateAndFinish(context,Widget screen)=>Navigator.pushReplacement(context,
  MaterialPageRoute(
    builder: (context) => screen,
  ),
);




Widget defaultButton({
  required Color backgroundColor,
  required Function onPressed,
  required Widget widget,
  double width = 100,
  double height = 40,

}) => ElevatedButton(
  onPressed: (){onPressed();},
  style: ElevatedButton.styleFrom(
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    minimumSize: Size(width.w, height.h),
  ),
  child: widget,
);



Widget defaultFormField({
  required String labelText,
  required TextInputType keyboardType,
  required IconData prefixIcon,
  required Function(String?) validator,
  required TextEditingController controller,
  bool obscureText = false,
  Function? onPressedSuffixIcon,
  //required Function validator,
  IconData? suffixIcon,
}) => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.r),
    color: Colors.white,
  ),
  child: TextFormField(
    obscureText: obscureText,
    validator: (value) {
      return validator(value);
      },
    onFieldSubmitted: (value){},
    onSaved: (value){},
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      prefixIcon: Icon(
          prefixIcon,
        color: Colors.black,
      ),
      suffixIcon: IconButton(
        onPressed: (){onPressedSuffixIcon!();},
        icon: Icon(
          suffixIcon,
          color: Colors.black,
        ),
      ),
      border: InputBorder.none,
    ),
  ),
);





Widget answer(context,{
  required String text,
  Color? borderColor,
})=> Material(
  borderRadius: BorderRadius.circular(5.r),
  elevation: 5,
  child: Container(
    padding: const EdgeInsetsDirectional.all(10),
    width: MediaQuery.of(context).size.width*0.43,
    height: MediaQuery.of(context).size.height*0.07,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(
        color: borderColor == null ? blackColor : borderColor,
        width: 0.6,
      ),
      color: Colors.white,
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
      ),
    ),
  ),
);



Widget examQuestion({
  required String questionVideoName,
  required Widget answerWidget,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image(
      image: AssetImage(questionVideoName),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        answerWidget,
        answerWidget
      ],
    ),
    SizedBox(height: 40.h,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        answerWidget,
        answerWidget,
      ],
    ),

  ],
);



Widget categoryComponent(context,{
  required String image,
  required String text,
  required Function onTap,

}) => GestureDetector(
  onTap: (){
    onTap();
    //navigate(context, CategoryItemsScreen());
  },
  child: Material(
    elevation: 8,
    //color: blackColor,
    borderRadius: BorderRadius.circular(10.r),
    child: Container(
      padding: const EdgeInsetsDirectional.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: MediaQuery.of(context).size.width*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Image(
            image: NetworkImage(image),
            width: 100.w,
            height: 80.h,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20.w,),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
            ),
          ),

        ],
      ),
    ),
  ),
);



Widget categoryItems(context, {
 // required var controller,
  required String word,
  required Function onTap,

}) => GestureDetector(
  onTap: (){
    onTap();
    //navigate(context, VideoScreen());
  },
  child:   Container(

    clipBehavior: Clip.antiAliasWithSaveLayer,

    // width: MediaQuery.of(context).size.width*0.5,

    // height: MediaQuery.of(context).size.height*0.2,



    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(10.r),

      color: Colors.white,

      border: Border.all(

        color: blackColor,

      ),

    ),

    child: Column(

      mainAxisSize: MainAxisSize.min,

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        // AspectRatio(

        //   aspectRatio: MediaQuery.of(context).size.height / MediaQuery.of(context).size.width,

        //   child: Chewie(

        //     controller: controller,

        //   ),

        // ),

        // SizedBox(height: 5.h,),

        Text(

          word,

          style: TextStyle(

            color: Colors.black,

            fontSize: 18.sp,

          ),

        ),



      ],

    ),

  ),
);
