import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/features/users/login/presentation/controller/state.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit(): super(InitialSocialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;



  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialChangeVisibilityLoginPassword());
  }

  void getUser({
    required String email,
    required String password
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      debugPrint(value.user!.email);
      debugPrint(value.user!.uid);
      emit(SocialLoginSuccessState());
    })
        .catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

}