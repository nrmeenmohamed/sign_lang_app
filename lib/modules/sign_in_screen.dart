import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/layout/home_layout.dart';
import 'package:sign_lang_app/modules/signup_screen.dart';
import '../shared/componenets/componenets.dart';
import '../shared/network/local/cache_helper.dart';
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if( state is AppSignInErrorState){
          print('error in sign in');
        }
        if(state is AppSignInSuccessState){
          CacheHelper.saveDate(
              key: 'uId',
              value: state.uId,
          ).then((value){
            print("saved id in cache helper ............................................");
            navigateAndFinish(context, const HomeLayout());
          }).catchError((error){
            print("???????error id in cache helper ${error.toString()} ???????????");

          });
        }
      },
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: const AssetImage('assets/images/signup.png'),
                    height:MediaQuery.of(context).size.height*0.4,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomPaint(
                    size: Size(
                      double.infinity,
                      MediaQuery.of(context).size.height*0.6,
                    ),
                    painter: RPSCustomPainter(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            elevation: 20,
                            borderRadius: BorderRadius.circular(10.r),
                            child: defaultFormField(
                              controller: emailController,
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email,
                              validator:(value)
                              {
                                if(value == null || value.isEmpty){
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 15.h,),
                          Material(
                            elevation: 20,
                            borderRadius: BorderRadius.circular(10.r),
                            child: defaultFormField(
                              obscureText: AppCubit.get(context).passwordShown,
                              controller: passwordController,
                              labelText: 'Password',
                              keyboardType: TextInputType.text,
                              prefixIcon: Icons.lock,
                              suffixIcon:  AppCubit.get(context).passwordShown ? Icons.visibility_off : Icons.visibility,
                              onPressedSuffixIcon: (){
                                AppCubit.get(context).showPassword();
                              },
                              validator:(value)
                              {
                                if(value == null || value.isEmpty){
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 15.h,),



                          ConditionalBuilder(
                            condition: state is! AppSignInLoadingState,
                            builder: (BuildContext context) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF0063ff),
                                    Color(0xFF0098e7),
                                    Colors.white,
                                  ],
                                ),
                              ),
                              child: defaultButton(
                                backgroundColor:Colors.transparent,
                                width: double.infinity,
                                height: 55.h,



                                onPressed: (){
                                  if (formKey.currentState != null && formKey.currentState!.validate()) {

                                    AppCubit.get(context).signIn(context,
                                      email: emailController.text,
                                      password: passwordController.text.trim(),
                                    );
                                    // CacheHelper.saveDate(key: 'uId', value: FirebaseAuth.instance.currentUser!.uid);

                                  }
                                },







                                widget: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                  ),
                                ),
                              ),
                            ),
                            fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(color: Colors.white,)),
                          ),











                          SizedBox(height: 15.h,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors:  [
                                  Color(0xFF030506),
                                  Color(0xFF243139),
                                  Colors.white,
                                ],
                              ),
                            ),
                            child: defaultButton(
                              backgroundColor: Colors.transparent,
                              width: double.infinity,
                              height: 55.h,
                              onPressed: (){
                                AppCubit.get(context).signInWithGoogle().
                                then((value) {
                                  navigateAndFinish(context, const HomeLayout());
                                }).catchError((error){
                                  print('??????? ${error.toString()} ???????????');
                                });
                              },
                              widget: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  Image(
                                    image: const AssetImage('assets/images/google.png'),
                                    width: 25.w,
                                    height: 25.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //SizedBox(height: 15.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                  'Don\'t have an account'
                              ),
                              TextButton(
                                onPressed: (){
                                  navigateAndFinish(context, SignupScreen());
                                },
                                child: const Text(
                                    'Signup'
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}











class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    // Layer 1

    Paint paint_fill_0 = Paint()
    //..color = const Color.fromARGB(220, 220, 220, 225)
    //..color = const Color.fromARGB(250, 250, 250, 250)
    // ..color =  blueColor
      ..color = const Color(0xFFaed9ed)


      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;


    Path path_0 = Path();
    // path_0.moveTo(size.width*1.0008333,size.height*0.0850000);
    path_0.moveTo(size.width*1.0008333,size.height*0.00850000);


    // path_0.quadraticBezierTo(size.width*0.7317083,size.height*0.2369167,size.width*0.6375417,size.height*0.2365000);
    // path_0.quadraticBezierTo(size.width*0.7317083,size.height*0.2369167,size.width*0.6355417,size.height*0.265000);





    // path_0.cubicTo(size.width*0.5646250,size.height*0.2365000,size.width*0.3348583,size.height*0.0539333,size.width*0.2247500,size.height*0.0067333);
    path_0.cubicTo(size.width*0.6250,size.height*0.365000,size.width*0.3348583,size.height*0.0539333,size.width*0.2247500,size.height*0.025333);

    path_0.quadraticBezierTo(size.width*0.1307333,size.height*-0.0008167,size.width*-0.0008333,size.height*0.0816667);



    //path_0.lineTo(size.width*0.0008333,size.height*0.9916667);
    path_0.lineTo(size.width*0.0008333,size.height*1.9916667);




    path_0.lineTo(size.width*0.9991667,size.height*0.9983333);
    // path_0.lineTo(size.width*1.0008333,size.height*0.0850000);
    path_0.lineTo(size.width*2.0008333,size.height);




    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);


    // Layer 1

    Paint paint_stroke_0 = Paint()
    // ..color = const Color.fromARGB(255, 62, 24, 2)
      ..color = const Color(0xFFaed9ed)

      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;



    canvas.drawPath(path_0, paint_stroke_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}







