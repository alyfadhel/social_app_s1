
abstract class SocialRegisterStates{}

class InitialRegisterSocialState extends SocialRegisterStates{}

class SocialChangeVisibilityRegisterPassword extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{
  final String uId;

  SocialRegisterSuccessState(this.uId);

}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;

  SocialRegisterErrorState(this.error);
}