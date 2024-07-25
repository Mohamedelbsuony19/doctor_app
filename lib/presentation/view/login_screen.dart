import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/routes.dart';
import '../widgets/custom_loading_indicator.dart';
import '../widgets/custom_text_filed.dart';
import '../widgets/data_save_botton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            loadInProgress: (value) {
              context.pop(context);
              customLoadingIndicator(context);
            },
            success: (value) {
              context.pop(context);
              context.go(Routes.layout);
              // Navigator.pushNamedAndRemoveUntil(
              //     context, Routes.clinicVendorHomeView, (route) => false);
            },
            failure: (value) {
              context.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.message)));
            },
          );
        },
        builder: (context, state) {
          return Stack(children: [
            Image.asset(
              "assets/spalsh.png",
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: MediaQuery.sizeOf(context).width * 0.15,
              left: MediaQuery.sizeOf(context).width * 0.05,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: DataSaveButton(
                    onPressed: () {
                      preferences.getString('token') != null
                          ? context.go(Routes.layout)
                          : showBottomSheet(
                              context: context,
                              builder: (context) {
                                return Form(
                                  key: formKey,
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(90, 217, 217, 217),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(20),
                                          )),
                                      child: Center(
                                          child: Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              'Login with Doctor Account',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      theme.colorScheme.primary,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Email can't be empty";
                                                }
                                                return null;
                                              },
                                              controller: usernameController,
                                              hintText: 'Enter Your Email'),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Password can't be empty";
                                                } else if (value.length < 8) {
                                                  return 'Password must be at least 8 characters';
                                                }
                                                return null;
                                              },
                                              controller: passwordController,
                                              obscureText: false,
                                              hintText: 'Enter Your Password'),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Spacer(),
                                          DataSaveButton(
                                            text: 'Login',
                                            onPressed: () {
                                              // authDataSource.login('admin', 'Admin123');
                                              if (formKey.currentState!
                                                  .validate()) {
                                                context.read<AuthBloc>().add(
                                                    AuthEvent.login(
                                                        username:
                                                            usernameController
                                                                .text,
                                                        password:
                                                            passwordController
                                                                .text));
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                );
                              });
                    },
                    text: 'Login'),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ]);
        },
      ),
    );
  }
}
