import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';
import 'package:social_app_sw1/core/shared/widgets/my_from_field.dart';
import 'package:social_app_sw1/core/shared/widgets/my_txt_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).socialUserModel!;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var cubit = SocialCubit.get(context);
        cubit.nameController.text = userModel.name;
        cubit.phoneController.text = userModel.phone;
        cubit.bioController.text = userModel.bio;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Iconly_Broken.Arrow___Left_2),
            ),
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              MyTxtButton(
                onPressed: () {},
                text: 'update',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color:
                      ThemeModeCubit.get(context).isDark
                          ? Colors.blue
                          : Colors.deepOrange,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 250.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                width: double.infinity,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage == null ? NetworkImage(
                                      userModel.cover,
                                    ) : FileImage(coverImage),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getCoverImage();
                              },
                              icon: CircleAvatar(
                                radius: 14.0,
                                backgroundColor:
                                    ThemeModeCubit.get(context).isDark
                                        ? Colors.blue
                                        : Colors.deepOrange,
                                child: Icon(
                                  Iconly_Broken.Camera,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 65.0,
                              child: CircleAvatar(
                                radius: 62,
                                backgroundImage: profileImage == null ? NetworkImage(
                                  userModel.image,
                                ) : FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 14.0,
                                backgroundColor:
                                    ThemeModeCubit.get(context).isDark
                                        ? Colors.blue
                                        : Colors.deepOrange,
                                child: Icon(
                                  Iconly_Broken.Camera,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  MyFromField(
                    controller: cubit.nameController,
                    type: TextInputType.text,
                    prefix: Iconly_Broken.User,
                    text: 'name',
                    radius: 10.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MyFromField(
                    controller: cubit.phoneController,
                    type: TextInputType.phone,
                    prefix: Iconly_Broken.Call,
                    text: 'phone',
                    radius: 10.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MyFromField(
                    controller: cubit.bioController,
                    type: TextInputType.text,
                    prefix: Iconly_Broken.Info_Circle,
                    text: 'bio',
                    radius: 10.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
