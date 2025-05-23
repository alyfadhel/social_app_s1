
abstract class SocialRegisterStates{}

class InitialRegisterSocialState extends SocialRegisterStates{}

class SocialChangeVisibilityRegisterPassword extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateUserLoadingState extends SocialRegisterStates{}
class SocialCreateUserSuccessState extends SocialRegisterStates{}
class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;

  SocialCreateUserErrorState(this.error);
}