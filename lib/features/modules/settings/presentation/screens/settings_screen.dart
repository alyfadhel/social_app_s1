import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';
import 'package:social_app_sw1/core/shared/widgets/my_button.dart';
import 'package:social_app_sw1/features/modules/settings/presentation/screens/edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).socialUserModel!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 250.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
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
                            image: CachedNetworkImageProvider(
                              userModel.cover,
                              errorListener: (p0) => Icons.error,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 65.0,
                      child: CircleAvatar(
                        radius: 62,
                        backgroundImage: CachedNetworkImageProvider(
                          userModel.image,
                          errorListener: (p0) => Icons.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                userModel.name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                userModel.bio,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        side: BorderSide(
                          color:
                              ThemeModeCubit.get(context).isDark
                                  ? Colors.blue
                                  : Colors.deepOrange,
                        ),
                      ),
                      child: Text(
                        'Add Photos',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(
                          color:
                              ThemeModeCubit.get(context).isDark
                                  ? Colors.blue
                                  : Colors.deepOrange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      side: BorderSide(
                        color:
                            ThemeModeCubit.get(context).isDark
                                ? Colors.blue
                                : Colors.deepOrange,
                      ),
                    ),
                    child: Icon(
                      Iconly_Broken.Edit,
                      color:
                          ThemeModeCubit.get(context).isDark
                              ? Colors.blue
                              : Colors.deepOrange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              MyButton(
                onPressed: () {},
                text: 'logout',
                background:
                    ThemeModeCubit.get(context).isDark
                        ? Colors.blue
                        : Colors.deepOrange,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
