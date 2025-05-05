import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_sw1/core/shared/widgets/my_button.dart';
import 'package:social_app_sw1/core/shared/widgets/my_from_field.dart';
import 'package:social_app_sw1/core/shared/widgets/my_txt_button.dart';
import 'package:social_app_sw1/features/users/login/presentation/screens/shop_login_screen.dart';
import 'package:social_app_sw1/features/users/register/presentation/controller/cubit.dart';
import 'package:social_app_sw1/features/users/register/presentation/controller/state.dart';


class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SocialLoginScreen()),
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
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
                          'Register',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.copyWith(fontSize: 40.0),
                        ),
                        Text(
                          'Register to Communicate with friends',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 40.0),
                        MyFromField(
                          controller: cubit.nameController,
                          type: TextInputType.text,
                          prefix: Icons.email_outlined,
                          text: 'name',
                          radius: 10.0,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must be not empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
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
                          controller: cubit.phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone_android,
                          text: 'phone',
                          radius: 10.0,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone must be not empty';
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
                          condition: state is! SocialRegisterLoadingState,
                          builder:
                              (context) => MyButton(
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.registerUser(
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
                              'Already have an account  ...',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10.0),
                            MyTxtButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SocialLoginScreen(),
                                  ),
                                );
                              },
                              text: 'login',
                              isUpperCase: false,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.blue, fontSize: 30.0),
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
