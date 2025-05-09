import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/layout/controller/state.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state)
      {

        var cubit = SocialCubit.get(context);

        return  Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: () {
                ThemeModeCubit.get(context).changeThemeMode();
              }, icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
