import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/routes.dart';
import 'custom_loading_indicator.dart';
import 'custom_text_filed.dart';
import 'data_save_botton.dart';

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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: BlocConsumer<AuthBloc, AuthState>(
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
            return Column(children: [
              const Spacer(),
              const Image(
                  image: NetworkImage(
                      'https://s3-alpha-sig.figma.com/img/8315/5627/682efec98982e5ddbb9043950af0f55d?Expires=1715558400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=JLaE5ZChF2BNlR90eG64wRsuUvd90qcdY5MYqX-3NEGbf6XHkeT0xY8DJw5SkYhQY6iHePG4mvdgY0rLfv0ROAXJOyjPJw5yNfWZg5WMSX58riOKpsF~5yCHArvqozYwdNe0aTIswGVxKEzP3b8~lKn3uiCsUYRBY5pejsCeWznpUzk83RTjn5Y-Sfp9dGmX60SfQsWhf-UyyA4gYDvYZa~7mc8vtf6Nqq5gJDGMbVTow39qxRKE2KXDqjmunCrCWCqOlm6R3DwC4K6rzHvrADHhfP6nfnG5uLaZGNaoygGU8OSfj0SO6cNPe7INRW8TydYnsq9Oj3Fqygi5p4s8tA__')),
              const Spacer(),
              DataSaveButton(
                  onPressed: () {
                    preferences.getString('token')!.isNotEmpty
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
              const SizedBox(
                height: 30,
              )
            ]);
          },
        ),
      ),
    );
  }
}
