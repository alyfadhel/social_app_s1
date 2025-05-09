import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/shared/model/social_user_model.dart';
import 'package:social_app_sw1/features/users/register/presentation/controller/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(InitialRegisterSocialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialChangeVisibilityRegisterPassword());
  }

  void registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          debugPrint(value.user!.email);
          debugPrint(value.user!.uid);
          createUser(
              name: name,
              email: email,
              phone: phone,
              uId: value.user!.uid,
          );
          emit(SocialRegisterSuccessState());
        })
        .catchError((error) {
          emit(SocialRegisterErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
}) {
    SocialUserModel socialUserModel = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      cover: 'https://img.freepik.com/premium-photo/fun-party-with-dj_23-2151108185.jpg?w=740',
      image: 'https://img.freepik.com/free-photo/fun-party-with-dj_23-2151108166.jpg?t=st=1746772103~exp=1746775703~hmac=34c964d049f4846dcc1b64747501e2cb4fae69983fa3b9f12f31024e2c6390da&w=740',
      bio: 'Write your bio ...',
    );
    emit(SocialCreateUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(socialUserModel.toMap())
        .then((value) {
          //emit(SocialCreateUserSuccessState());
    })
        .catchError((error) {
          emit(SocialCreateUserErrorState(error.toString()));
          debugPrint(error.toString());
    });
  }
}
