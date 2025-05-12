import 'package:flutter/material.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/model/post_model.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';

class BuildHomeItem extends StatelessWidget {
  final PostModel model;
  final int index;
  const BuildHomeItem({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    'https://img.freepik.com/premium-photo/trees-growing-forest_1048944-30368869.jpg?w=740',
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context).textTheme.bodySmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
              thickness: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            child: Text(
              model.text,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          if(model.postImage.isNotEmpty)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  model.postImage,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Iconly_Broken.Heart, color: Colors.red),
                      SizedBox(width: 10.0),
                      Text(
                        '${SocialCubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Iconly_Broken.Chat, color: Colors.amber),
                      SizedBox(width: 10.0),
                      Text(
                        'Comment',
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
              thickness: 1.5,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          SocialCubit.get(context).socialUserModel!.image,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        'Write a comment ...',
                        style: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Iconly_Broken.Heart, color: Colors.red),
                      SizedBox(width: 10.0),
                      Text(
                        'Like',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: (){
                    SocialCubit.get(context).likePosts(
                      SocialCubit.get(context).postId[index]
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
