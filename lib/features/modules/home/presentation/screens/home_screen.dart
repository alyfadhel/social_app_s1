import 'package:flutter/material.dart';
import 'package:social_app_sw1/core/shared/themes/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                elevation: 5.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  width: double.infinity,
                  height: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://img.freepik.com/premium-photo/medium-shot-woman-living-farmhouse_23-2150621719.jpg?w=740',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Text(
                  'Communicate With Friends',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildHomeItem(context),
              separatorBuilder: (context, index) => SizedBox(height: 10.0,),
              itemCount: 10,
          ),
        ],
      ),
    );
  }
}

Widget buildHomeItem(context)=>Card(
  margin: EdgeInsets.symmetric(horizontal: 8.0),
  elevation: 5.0,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Column(
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
                        'Aly Fadhel',
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
                    'May,09,2025',
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
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.justify,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://img.freepik.com/premium-photo/trees-growing-forest_1048944-30368869.jpg?w=740',
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
                    'Like',
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
                      'https://img.freepik.com/free-photo/fun-party-with-dj_23-2151108197.jpg?t=st=1746777810~exp=1746781410~hmac=b691376821e6194dd0d26805125a9376b4afcea5306e7d98a59a5a4fe9a89339&w=740',
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
              onTap: (){},
            ),
          ),
        ],
      ),
      SizedBox(height: 20.0),
    ],
  ),
);