import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/controller/cubit.dart';
import 'package:social_app_sw1/core/layout/social_layout.dart';
import 'package:social_app_sw1/core/shared/const/constanse.dart';
import 'package:social_app_sw1/core/shared/network/local/cache_helper.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/themes/controller/state.dart';
import 'package:social_app_sw1/core/shared/themes/theme_mode.dart';
import 'package:social_app_sw1/features/users/login/presentation/screens/shop_login_screen.dart';
import 'package:social_app_sw1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  bool? isDark = CacheHelper.getData(key: 'isDark');
  uId = CacheHelper.getData(key: 'uId');
  Widget widget;

  if(uId != null){
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }
  runApp(MyApp(isDark: isDark, startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp({super.key, required this.isDark, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  ThemeModeCubit()..changeThemeMode(fromShared: isDark),
        ),
        BlocProvider(create: (context) => SocialCubit()..getUser(),),
      ],
      child: BlocConsumer<ThemeModeCubit, ThemeModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getLightMode(),
            darkTheme: getDarkMode(),
            themeMode: ThemeModeCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
