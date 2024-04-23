import 'package:bloc/bloc.dart';
import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_lang_app/cubit/cubit.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/layout/home_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sign_lang_app/shared/componenets/constants.dart';
import 'firebase_options.dart';
import 'cubit/bloc_observer.dart';
import 'modules/onboarding_screen.dart';
import 'modules/welcome_screen.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sign_lang_app/shared/network/local/cache_helper.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  Widget widget;

  bool? boarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');



    if(boarding != null){
      if(uId != null){
        widget = const HomeLayout();
      }
      else{
        widget = const WelcomeScreen();
      }
    }else{
      widget = OnboardingScreen();
    }


  debugPrint('  onBoarding = $boarding\nuId = $uId\n');



  runApp(MyApp(startWidget: widget));

}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  
  

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (BuildContext context) => AppCubit()..getCategoryFromFirebase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {  },
          builder: (BuildContext context, AppStates state) {
            return MaterialApp(
              debugShowCheckedModeBanner:false,
              navigatorObservers: [FlutterSmartDialog.observer],
              builder: FlutterSmartDialog.init(),
              home:  startWidget,
            );
          },
        ),
      ),
    );
  }
}
