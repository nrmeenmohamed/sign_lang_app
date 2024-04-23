import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:sign_lang_app/modules/welcome_screen.dart';
import 'package:sign_lang_app/shared/styles/colors.dart';

import '../shared/network/local/cache_helper.dart';

class OnboardingScreen extends StatelessWidget {
   OnboardingScreen({super.key});



   final introKey = GlobalKey<IntroductionScreenState>();

   // navigator
   void _onIntroEnd(context) {
     Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (_) => WelcomeScreen()),
     );
   }

   Widget _buildImage(String assetName, [double width = 350]) {
     return Image.asset('assets/images/$assetName', width: width);
   }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 17.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      //imagePadding: EdgeInsets.zero,
      imagePadding: EdgeInsets.only(
        top: 30,
      ),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      pages: [
        PageViewModel(
          title: "Learn at Your Own Pace",
          body: 'Learn sign language at your own pace with our easy-to-follow lessons. Swipe through the signs, practice at your convenience, and track your progress along the way',
          image: _buildImage('on_1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Explore Different Categories",
          body:
        'Explore a wide range of categories, from basic signs to advanced expressions. Discover new signs, practice vocabulary, and expand your sign language skills.',
          image: _buildImage('on_2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Practice with Interactive Quizzes",
          body:
        'Test your knowledge with interactive quizzes. Reinforce your learning by practicing what you\'ve learned ',
          image: _buildImage('on_3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: (){
        _onIntroEnd(context);
        CacheHelper.saveDate(key: 'onBoarding', value: true);
      } ,
      onSkip: () {
        _onIntroEnd(context);
        CacheHelper.saveDate(key: 'onBoarding', value: true);
      }, // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(Icons.arrow_back, color: Colors.white),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      next: const Icon(Icons.arrow_forward, color: Colors.white),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator:  DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Colors.white,
        activeColor: yellowColor,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator:  ShapeDecoration(
        color: blueColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
