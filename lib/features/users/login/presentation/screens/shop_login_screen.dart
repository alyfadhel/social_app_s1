import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/layout/social_layout.dart';
import 'package:social_app_sw1/core/shared/const/constanse.dart';
import 'package:social_app_sw1/core/shared/network/local/cache_helper.dart';
import 'package:social_app_sw1/core/shared/themes/controller/cubit.dart';
import 'package:social_app_sw1/core/shared/widgets/my_button.dart';
import 'package:social_app_sw1/core/shared/widgets/my_from_field.dart';
import 'package:social_app_sw1/core/shared/widgets/my_txt_button.dart';
import 'package:social_app_sw1/core/shared/widgets/toast_state.dart';
import 'package:social_app_sw1/features/users/login/presentation/controller/cubit.dart';
import 'package:social_app_sw1/features/users/login/presentation/controller/state.dart';
import 'package:social_app_sw1/features/users/register/presentation/screens/shop_register_screen.dart';
import 'package:social_app_sw1/main.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToastState(msg: state.error, state: ToastState.error);
          }

          if (state is SocialLoginSuccessState) {
            CacheHelper.setData(key: 'uId', value: state.uId).then((value) {
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MyApp(
                          isDark: ThemeModeCubit.get(context).isDark,
                          startWidget: SocialLayout(),
                        ),
                  ),
                );
              }
            });
            uId = state.uId;
          }
        },
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: cubit.formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.copyWith(fontSize: 40.0),
                        ),
                        Text(
                          'Login to Communicate with friends',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 40.0),
                        MyFromField(
                          controller: cubit.emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email_outlined,
                          text: 'email address',
                          radius: 10.0,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must be not empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        MyFromField(
                          controller: cubit.passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outline,
                          text: 'password',
                          radius: 10.0,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must be not empty';
                            }
                            return null;
                          },
                          suffix: cubit.suffix,
                          isPassword: cubit.isPassword,
                          onSuffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        SizedBox(height: 40.0),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder:
                              (context) => MyButton(
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.getUser(
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                          fallback:
                              (context) =>
                                  Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?!',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10.0),
                            MyTxtButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => SocialRegisterScreen(),
                                  ),
                                );
                              },
                              text: 'Register',
                              isUpperCase: false,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.red, fontSize: 30.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
