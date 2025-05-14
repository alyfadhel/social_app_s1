import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app_sw1/core/shared/model/social_user_model.dart';
import 'package:social_app_sw1/features/modules/chat/presentation/screens/chat_details_screen.dart';

class BuildUsersItem extends StatelessWidget {
  final SocialUserModel model;

  const BuildUsersItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatDetailsScreen(
            socialUserModel: model,
          )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: CachedNetworkImageProvider(
                    model.image,
                    errorListener: (p0) => Icons.error_outline,
                    scale: 40.0,
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
