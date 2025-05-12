import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/core/shared/const/constanse.dart';
import 'package:social_app_sw1/core/shared/model/post_model.dart';
import 'package:social_app_sw1/core/shared/model/social_user_model.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';
import 'package:social_app_sw1/features/modules/chat/presentation/screens/chat_screen.dart';
import 'package:social_app_sw1/features/modules/home/presentation/screens/home_screen.dart';
import 'package:social_app_sw1/features/modules/post/presentation/screens/post_screen.dart';
import 'package:social_app_sw1/features/modules/settings/presentation/screens/settings_screen.dart';
import 'package:social_app_sw1/features/modules/users/presentation/screens/users_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialSocialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? socialUserModel;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var textController = TextEditingController();

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

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Iconly_Broken.Home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Iconly_Broken.Chat), label: 'Chat'),
    BottomNavigationBarItem(
      icon: Icon(Iconly_Broken.Paper_Upload),
      label: 'Post',
    ),
    BottomNavigationBarItem(icon: Icon(Iconly_Broken.User), label: 'Users'),
    BottomNavigationBarItem(
      icon: Icon(Iconly_Broken.Setting),
      label: 'Settings',
    ),
  ];

  List<String> titles = ['Home', 'Chat', 'Post', 'Users', 'Settings'];

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    PostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNav(index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                updateUser(name: name, phone: phone, bio: bio, image: value);
              })
              .catchError((error) {
                emit(SocialUploadProfileImageErrorState());
              });
          emit(SocialUploadProfileImageSuccessState());
        })
        .catchError((error) {
          emit(SocialUploadProfileImageErrorState());
        });
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                updateUser(name: name, phone: phone, bio: bio, cover: value);
              })
              .catchError((error) {
                emit(SocialUploadCoverImageErrorState());
              });
          emit(SocialUploadCoverImageSuccessState());
        })
        .catchError((error) {
          emit(SocialUploadProfileImageErrorState());
        });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: socialUserModel!.email,
      phone: phone,
      uId: socialUserModel!.uId,
      cover: cover ?? socialUserModel!.cover,
      image: image ?? socialUserModel!.image,
      bio: bio,
    );
    emit(SocialUserUpdateLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(socialUserModel!.uId)
        .update(model.toMap())
        .then((value) {
          getUser();
          emit(SocialUserUpdateSuccessState());
        })
        .catchError((error) {
          emit(SocialUserUpdateErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({required String text, required String dateTime}) {
    emit(SocialCreatePostLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                createPost(dateTime: dateTime, text: text, postImage: value);
                removePost();
              })
              .catchError((error) {
                emit(SocialUploadCoverImageErrorState());
              });
          emit(SocialUploadCoverImageSuccessState());
        })
        .catchError((error) {
          emit(SocialUploadProfileImageErrorState());
        });
  }

  void removePost() {
    postImage = null;
    emit(SocialRemovePostState());
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: socialUserModel!.name,
      uId: socialUserModel!.uId,
      image: socialUserModel!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    emit(SocialCreatePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          textController.clear();
          getPosts();
          emit(SocialCreatePostSuccessState());
        })
        .catchError((error) {
          emit(SocialCreatePostErrorState());
        });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    posts = [];
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
                  likes.add(value.docs.length);
                  postId.add(element.id);
                  posts.add(PostModel.fromJson(element.data()));
            })
                .catchError((error) {
              emit(SocialGetPostsErrorState(error.toString()));
              debugPrint(error.toString());
            });
            debugPrint('The Posts Is : ${element.data()}');
            emit(SocialGetPostsSuccessState());
          });
        })
        .catchError((error) {
          emit(SocialGetPostsErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(socialUserModel!.uId)
        .set({'like': true})
        .then((value) {
          emit(SocialGetLikePostsSuccessState());
        })
        .catchError((error) {
          emit(SocialGetLikePostsErrorState(error.toString()));
          debugPrint(error.toString());
        });
  }
}
