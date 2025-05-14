import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/features/modules/chat/presentation/widgets/build_users_item.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).socialUserModel;
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder:
              (context) => ListView.separated(
                itemBuilder:
                    (context, index) =>
                        BuildUsersItem(model: cubit.users[index]),
                separatorBuilder: (context, index) => SizedBox(height: 20.0),
                itemCount: cubit.users.length,
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
