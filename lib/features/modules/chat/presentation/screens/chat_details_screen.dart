import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/core/shared/model/message_model.dart';
import 'package:social_app_sw1/core/shared/model/social_user_model.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel socialUserModel;

  const ChatDetailsScreen({super.key, required this.socialUserModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverId: socialUserModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 60.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Iconly_Broken.Arrow___Left_2),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: CachedNetworkImageProvider(
                        socialUserModel.image,
                        errorListener: (p0) => Icons.error_outline,
                        scale: 40.0,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      socialUserModel.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var messages = SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).socialUserModel!.uId == messages.senderId){
                              return buildMyMessage(context, messages);
                            }else{
                              return buildMessage(context, messages);
                            }
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(height: 20.0),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  controller: cubit.messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here ...',
                                    hintStyle: TextStyle(
                                      color:
                                      ThemeModeCubit.get(context).isDark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color:
                                ThemeModeCubit.get(context).isDark
                                    ? Colors.blue
                                    : Colors.deepOrange,
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  cubit.sendMessage(
                                    receiverId: socialUserModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: cubit.messageController.text,
                                  );
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  Iconly_Broken.Send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildMessage(context, MessageModel model) => Align(
  alignment: AlignmentDirectional.topStart,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.blue.shade300,
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(8.0),
        topEnd: Radius.circular(8.0),
        bottomEnd: Radius.circular(8.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text(model.text, style: Theme.of(context).textTheme.titleMedium),
    ),
  ),
);

Widget buildMyMessage(context, MessageModel model) => Align(
  alignment: AlignmentDirectional.topEnd,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.green.shade300,
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(8.0),
        topEnd: Radius.circular(8.0),
        bottomStart: Radius.circular(8.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Text(model.text, style: Theme.of(context).textTheme.titleMedium),
    ),
  ),
);

// Ali c5P28n476DcJ2e4T0eJBaNxOhiW2
// Ahmed c5P28n476DcJ2e4T0eJBaNxOhiW2
