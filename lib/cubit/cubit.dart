import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_lang_app/cubit/sates.dart';
import 'package:sign_lang_app/modules/reviewListScreen.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import '../models/category_model.dart';
import '../models/review_list_model.dart';
import '../models/user_info_model.dart';
import '../models/video_model.dart';
import '../modules/category_screen.dart';
import '../modules/information_screen.dart';
import '../modules/quiz_screen.dart';
import '../shared/componenets/constants.dart';
import '../shared/styles/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  static FirebaseAuth auth = FirebaseAuth.instance;

  // password shown

  bool passwordShown = true;

  void showPassword() {
    passwordShown = !passwordShown;
    emit(AppPasswordShownState());
  }

  // Nave bar
  int currentIndex = 0;
  List<Widget> screens = [
    CategoryScreen(),
    InformationScreen(),
    QuizScreen(),
    ReviewListScreen(),
  ];
  List<BottomBarItem> bottomItems = [
    BottomBarItem(
      icon: const Icon(
        Icons.category_outlined,
      ),
      selectedIcon: const Icon(Icons.category_rounded),
      // selectedColor: Colors.teal,
      backgroundColor: Colors.white,
      title: const Text('Category'),
    ),
    BottomBarItem(
      icon: const Icon(Icons.info_outline),
      selectedIcon: const Icon(Icons.info_outline_rounded),
      //selectedColor: Colors.white,
      //unSelectedColor: Colors.white,
      backgroundColor: Colors.white,
      title: const Text('Information'),
    ),
    BottomBarItem(
        icon: const Icon(
          Icons.quiz_outlined,
        ),
        selectedIcon: const Icon(
          Icons.quiz_rounded,
        ),
        backgroundColor: Colors.white,
        //selectedColor: Colors.deepOrangeAccent,
        title: const Text('Test')),
    BottomBarItem(
        icon: const Icon(
          Icons.list_alt_outlined,
        ),
        selectedIcon: const Icon(
          Icons.list_alt_rounded,
        ),
        backgroundColor: Colors.white,
        //selectedColor: Colors.deepPurple,
        title: const Text('Review')),
  ];

  void changeNaveItem(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  // toggle between light & dark mode
  void setMode() {
    whitColor = isDark ? Colors.black : Colors.white;
    blackColor = isDark ? Colors.white : Colors.black;
    lightGreyColor = isDark ? Colors.grey[900] : Colors.grey[300];
    emit(AppChangeModeState());
    print('******* change mode *************');
    isDark = !isDark;

  }


  // firebase ...........................................................................................

  void signup(context,{
    required String email,
    required String password,
    required String userName,
    required String age,
  }) async {
    emit(AppSignupLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      createUser(
        email: email,
        userName: userName,
        age: age,
        userId: value.user!.uid,
      );
      print('sign up user successfully ***************************************');
    }).catchError((error) {
      String errorMessage = 'An error occurred.';
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          errorMessage = 'The email address is already in use.';
        } else {
          errorMessage = error.message ?? errorMessage;
        }
      } else {
        print('An unexpected error occurred: $error');
        errorMessage = 'An unexpected error occurred. Please try again.';
      }

      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );

      emit(AppSignupErrorState(errorMessage));
    });
  }

  void createUser({
    required String email,
    required String userName,
    required String age,
    required String userId,
    String? userImage,
  }) {
    UserModel userModel = UserModel(
        email: email,
        username: userName,
        age: age,
        userId: userId,
        image: userImage,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .set(userModel.toMap())
        .then((value) {
      emit(AppCreateUserSuccessState(uId: userId));
      print('create user successfully ***************************************');
    }).catchError((error) {
      emit(AppCreateUserErrorState(error.toString()));
      print('??????? ${error.toString()}');
    });
  }

  UserModel userModel = UserModel();
  void getUser() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      emit(AppGetUserErrorState(error.toString()));
      print('???? error in get user ${error.toString()} ????????????');
    });
  }



  void signIn(
      context, {
        required String email,
        required String password,
      }) async {
    emit(AppSignInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(AppSignInSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      String errorMessage = 'An error occurred.';
      if (error is FirebaseAuthException) {
        if (error.code == 'firebase_auth/invalid-credential') {
          errorMessage =
          'The supplied auth credential is incorrect, malformed, or has expired.';
        } else if (error.code == 'firebase_auth/user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (error.code == 'firebase_auth/wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage = error.message ?? errorMessage;
        }
      }

      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      emit(AppSignInErrorState(errorMessage));
      getUser();
    }).catchError((error) {
      // Handle other types of errors
      print('An unexpected error occurred: $error');
      emit(AppSignInErrorState(error.toString()));
    });
  }




  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    emit(AppSignInWithGoogleLoadingState());

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    emit(AppSignInWithGoogleSuccessState());

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(AppLogoutState());
  }


  List<String> categoryIds = [];
  List<CategoryModel> categories = [];

  void getCategoryFromFirebase() {
    FirebaseFirestore.instance
        .collection('category')
        .snapshots()
        .listen((event) {
      categories = [];
      categoryIds = [];
      event.docs.forEach((element) {
        categories.add(CategoryModel.fromJson(element.data()));
        categoryIds.add(element.id);
        print(categoryIds);
      });
      emit(AppGetCategorySuccessState());
    });
  }

  List<VideoModel> videos = [];

  void getVideoFromFireBase({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('category')
        .doc(id)
        .collection('video')
        .snapshots()
        .listen((event) {
      videos = [];
      event.docs.forEach((element) {
        videos.add(VideoModel.fromJson(element.data()));
      });
      emit(AppGetVideoSuccessState());
    });
  }

  void addReviewList({
    required String videoWord,
    required String videoUrl,
  }) {
    ReviewListModel reviewListModel = ReviewListModel(
      videoWord: videoWord,
      videoUrl: videoUrl,
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('reviewList')
        .add(reviewListModel.toMap())
        .then((value) {
      emit(AppAddReviewListSuccessState());
    }).catchError((error) {
      emit(AppAddReviewListErrorState(error.toString()));
      print('??????? ${error.toString()}');
    });
  }

  List<String> reviewListIds = [];
  List<ReviewListModel> reviews = [];
  void getReviewListFromFireBase() {
    FirebaseFirestore.instance
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('reviewList')
        .snapshots()
        .listen((event) {
      reviews = [];
      reviewListIds = [];
      event.docs.forEach((element) {
        reviews.add(ReviewListModel.fromJson(element.data()));
        reviewListIds.add(element.id);
      });
      emit(AppGetReviewListSuccessState());
      print(
          '************************************************************************************');
    });
  }

  void deleteFromReviewList({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('reviewList')
        .doc(id)
        .delete()
        .then((value) {
      emit(AppDeleteFromReviewListSuccessState());
    }).catchError((error) {
      emit(AppDeleteFromReviewListErrorState(error.toString()));
      print("????????????????????????? ${error.toString()} ????????????????/");
    });
  }

  bool getImage = false;
  File? file;
  String? url;

  uploadImage({required bool isCamera}) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image;
    if (isCamera) {
      image = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      file = File(image!.path);
      getImage = true;

      var metaData = SettableMetadata(
        contentType: 'image/jpeg',
      );
      var imageName = basename(image.path);
      var ref = FirebaseStorage.instance.ref('user_images/$imageName');
      await ref.putFile(file!, metaData);
      url = await ref.getDownloadURL();
      print('$url ---------------');

      emit(AppUploadImageSuccessState());

       getImage = false;
    }
  }




  void updateUser({
    required String email,
    required String userName,
    required String age,

  }){
    UserModel userModel = UserModel(
      email: email,
      username: userName,
      age: age,
      image:url,
      userId: uId,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .update(userModel.toMap()).
    then((value) {
      getUser();
    }).catchError((error){
      print('??? error in update user data ${error.toString()} ??????????????');
      emit(AppUpdateUserErrorState(error.toString()));
    });
  }
}
