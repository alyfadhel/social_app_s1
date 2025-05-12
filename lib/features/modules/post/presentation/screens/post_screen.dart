import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';
import 'package:social_app_sw1/core/shared/widgets/my_txt_button.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).socialUserModel;
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Iconly_Broken.Arrow___Left_2),
            ),
            title: Text('Create Post'),
            actions: [
              MyTxtButton(
                onPressed: () {
                  if(cubit.postImage == null){
                    cubit.createPost(
                      dateTime: DateTime.now().toString(),
                      text: cubit.textController.text,
                    );
                  }else{
                    cubit.uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      text: cubit.textController.text,
                    );
                  }

                },
                text: 'post',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color:
                      ThemeModeCubit.get(context).isDark
                          ? Colors.blue
                          : Colors.deepOrange,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(height: 20.0),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: CachedNetworkImageProvider(
                        userModel!.image,
                        errorListener: (p0) => Icons.error,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      userModel.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: TextFormField(
                    controller: cubit.textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What is on your mind ...',
                      hintStyle: TextStyle(
                        color:
                            ThemeModeCubit.get(context).isDark
                                ? Colors.grey
                                : Colors.white,
                      ),
                    ),
                  ),
                ),
                if(cubit.postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(cubit.postImage!),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.removePost();
                      },
                      icon: CircleAvatar(
                        radius: 12.0,
                        backgroundColor: ThemeModeCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconly_Broken.Image,
                              size: 30.0,
                              color:
                                  ThemeModeCubit.get(context).isDark
                                      ? Colors.blue
                                      : Colors.deepOrange,
                            ),
                            SizedBox(width: 8.0),
                            Text(
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# Tags',
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
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
