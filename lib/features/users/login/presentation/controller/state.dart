
abstract class SocialLoginStates{}

class InitialSocialState extends SocialLoginStates{}

class SocialChangeVisibilityLoginPassword extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;

  SocialLoginErrorState(this.error);
}