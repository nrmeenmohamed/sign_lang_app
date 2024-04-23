abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppChangeNavBarState extends AppStates{}

class AppChangeModeState extends AppStates{}

class AppPasswordShownState extends AppStates{}

class AppSignupLoadingState extends AppStates{}

class AppSignupSuccessState extends AppStates{
  final String uId;
  AppSignupSuccessState({required this.uId});
}

class AppSignupErrorState extends AppStates{
  final String error;
  AppSignupErrorState(this.error);
}

class AppSignInLoadingState extends AppStates{}

class AppSignInSuccessState extends AppStates{
  final String uId;
  AppSignInSuccessState({required this.uId});
}

class AppSignInErrorState extends AppStates{
  final String error;
  AppSignInErrorState(this.error);
}

class AppSignInWithGoogleLoadingState extends AppStates{}

class AppSignInWithGoogleSuccessState extends AppStates{}

class AppSignInWithGoogleErrorState extends AppStates{
  final String error;
  AppSignInWithGoogleErrorState(this.error);
}

class AppCreateUserSuccessState extends AppStates{
  final String uId;
  AppCreateUserSuccessState({required this.uId});
}

class AppCreateUserErrorState extends AppStates{
  final String error;
  AppCreateUserErrorState(this.error);
}

class AppGetUserLoadingState extends AppStates{}

class AppGetUserSuccessState extends AppStates{}

class AppGetUserErrorState extends AppStates{
  final String error;
  AppGetUserErrorState(this.error);
}

class AppGetCategoryLoadingState extends AppStates{}

class AppGetCategorySuccessState extends AppStates{}

class AppGetCategoryErrorState extends AppStates{
  final String error;
  AppGetCategoryErrorState(this.error);
}

class AppGetVideoLoadingState extends AppStates{}

class AppGetVideoSuccessState extends AppStates{}

class AppGetVideoErrorState extends AppStates{
  final String error;
  AppGetVideoErrorState(this.error);
}

class AppAddReviewListSuccessState extends AppStates{}

class AppAddReviewListErrorState extends AppStates{
  final String error;
  AppAddReviewListErrorState(this.error);
}

class AppGetReviewListSuccessState extends AppStates{}

class AppGetReviewListErrorState extends AppStates{
  final String error;
  AppGetReviewListErrorState(this.error);
}

class AppDeleteFromReviewListSuccessState extends AppStates{}

class AppDeleteFromReviewListErrorState extends AppStates{
  final String error;
  AppDeleteFromReviewListErrorState(this.error);
}

class AppPlayVideoSuccessState extends AppStates{}

class AppUploadImageSuccessState extends AppStates{}

class AppUpdateUserErrorState extends AppStates{
  final String error;
  AppUpdateUserErrorState(this.error);
}

class AppLogoutState extends AppStates {}