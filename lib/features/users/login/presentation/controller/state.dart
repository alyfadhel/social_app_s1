
abstract class SocialLoginStates{}

class InitialSocialState extends SocialLoginStates{}

class SocialChangeVisibilityLoginPassword extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{
  final String uId;

  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;

  SocialLoginErrorState(this.error);
}