import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap(context) {
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(' ')[0];
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v10,
            const Text(
              "Your birthday won't be shown publicly",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.black45,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _birthdayController,
              decoration: InputDecoration(
                hintText: "Birthday",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v24,
            FormButton(
              disabled: ref.watch(signUpProvider).isLoading,
              onTapFunction: _onNextTap,
              text: "Next",
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 300,
        child: BottomAppBar(
          surfaceTintColor: Colors.transparent,
          child: CupertinoDatePicker(
            onDateTimeChanged: _setTextFieldDate,
            mode: CupertinoDatePickerMode.date,
            // User has to be at least 7 years old
            maximumDate: DateTime(
                initialDate.year - 7, initialDate.month, initialDate.day,),
            initialDateTime: DateTime(
                initialDate.year - 7, initialDate.month, initialDate.day,),
          ),
        ),
      ),
    );
  }
}
