import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/core/shared/const/constanse.dart';
import 'package:social_app_sw1/core/shared/model/social_user_model.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';
import 'package:social_app_sw1/features/modules/chat/presentation/screens/chat_screen.dart';
import 'package:social_app_sw1/features/modules/home/presentation/screens/home_screen.dart';
import 'package:social_app_sw1/features/modules/settings/presentation/screens/settings_screen.dart';
import 'package:social_app_sw1/features/modules/users/presentation/screens/users_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialSocialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? socialUserModel;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  void getUser() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          socialUserModel = SocialUserModel.fromJson(value.data()!);
          debugPrint('The Users : ${value.data()}');
          emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
          emit(SocialGetUserErrorState(error.toString()));
          debugPrint(error.toString());
    });
  }

  List<BottomNavigationBarItem>items=[
    BottomNavigationBarItem(icon: Icon(Iconly_Broken.Home,),label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Iconly_Broken.Chat,),label: 'Chat'),
    BottomNavigationBarItem(icon: Icon(Iconly_Broken.User,),label: 'Users'),
    BottomNavigationBarItem(icon: Icon(Iconly_Broken.Setting,),label: 'Settings'),
  ];

  List<String>titles = [
    'Home',
    'Chat',
    'Users',
    'Settings',
  ];

  List<Widget>screens = [
    HomeScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNav(index)
  {
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future getCoverImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }
}
