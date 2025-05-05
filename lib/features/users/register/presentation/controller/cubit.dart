import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/features/users/register/presentation/controller/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit(): super(InitialRegisterSocialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;



  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialChangeVisibilityRegisterPassword());
  }

  void registerUser({
    required String email,
    required String password,
})
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.
    createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      debugPrint(value.user!.email);
      debugPrint(value.user!.uid);
      emit(SocialRegisterSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }


}