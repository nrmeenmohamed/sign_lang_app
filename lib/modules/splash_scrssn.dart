// import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
// import 'package:flutter/material.dart';
//
// import '../shared/network/local/cache_helper.dart';
// import 'onboarding_screen.dart';
//
// class SplashScreen extends StatelessWidget {
//   SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: FlutterSplashScreen.scale(
//         backgroundColor: Colors.white,
//         useImmersiveMode : true, // hide status bar
//         onInit: () {
//           debugPrint("On Init");
//         },
//         onEnd: () {
//           CacheHelper.saveDate(key: 'splash', value: true);
//           debugPrint("On End");
//         },
//         childWidget: SizedBox(
//           height: 300,
//           width: 300,
//           child:Image(
//             image:  AssetImage('assets/images/w.PNG'),
//           ),
//         ),
//         onAnimationEnd: () => debugPrint("On Fade In End"),
//         nextScreen: OnboardingScreen(),
//           //duration: Duration(seconds: 10),
//       ),
//     );
//   }
// }
