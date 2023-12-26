import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/login_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  LoginFormScreenState createState() => LoginFormScreenState();
}

class LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _onSubmitTap(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // login
        ref.read(loginProvider.notifier).login(
              _formData['email']!,
              _formData['password']!,
              context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
          vertical: Sizes.size28,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value == "") {
                    return "Please enter your email";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    _formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                validator: (value) {
                  if (value == "") {
                    return "Password is not correct";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    _formData['password'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              FormButton(
                disabled: ref.watch(loginProvider).isLoading,
                onTapFunction: _onSubmitTap,
                text: "Log in",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
