import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinc_vandor/presentation/widgets/show_snack_bar.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _changePassword() {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    if (_formKey.currentState!.validate()) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'change password',
        desc: 'Are you sure you want to change your password?',
        btnCancelOnPress: () {
          context.pop(context);
        },
        btnOkOnPress: () async {
          context.read<AuthBloc>().add(AuthEvent.changePassword(
              currentPassword: oldPassword, newPassword: newPassword));
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: theme.colorScheme.primary));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  failure: (v) {
                    ShowSnackbar.showCheckTopSnackBar(context,
                        text: v.message, type: SnackBarType.error);
                  },
                  success: (v) {
                    if (v.changedPassword) {
                      context.pop(context);
                      ShowSnackbar.showCheckTopSnackBar(context,
                          text: 'Password changed successfully',
                          type: SnackBarType.success);
                    }
                  });
            },
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                  controller: _oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Old Password",
                    hintText: "Old Password",
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder.copyWith(
                        borderSide:
                            BorderSide(color: theme.colorScheme.primary)),
                    disabledBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder.copyWith(
                        borderSide:
                            BorderSide(color: theme.colorScheme.primary)),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "New Password",
                    labelText: "New Password",
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder.copyWith(
                        borderSide:
                            BorderSide(color: theme.colorScheme.primary)),
                    disabledBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder.copyWith(
                        borderSide:
                            BorderSide(color: theme.colorScheme.primary)),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder.copyWith(
                        borderSide:
                            BorderSide(color: theme.colorScheme.primary)),
                    disabledBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder.copyWith(
                        borderSide:
                            BorderSide(color: theme.colorScheme.primary)),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(
                      MediaQuery.sizeOf(context).width * 0.9,
                      50,
                    ),
                  ),
                  onPressed: _changePassword,
                  child: Text(
                    'Save',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
