import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/shared/network/local/cache_helper.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/themes/controller/state.dart';
import 'package:social_app_sw1/features/users/login/presentation/screens/shop_login_screen.dart';
import 'package:social_app_sw1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({super.key, required this.isDark});

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
      ],
      child: BlocConsumer<ThemeModeCubit, ThemeModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SocialLoginScreen(),
          );
        },
      ),
    );
  }
}
