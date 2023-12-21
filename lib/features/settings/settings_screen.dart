import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _onNotificationChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: Sizes.size16,
          ),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: _notification,
            onChanged: _onNotificationChanged,
            title: const Text("Automute"),
            subtitle: const Text("Disable sound as default"),
          ),
          SwitchListTile.adaptive(
            value: _notification,
            onChanged: _onNotificationChanged,
            title: const Text("enable notification"),
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: _notification,
            onChanged: _onNotificationChanged,
            title: const Text("Enable notifications"),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.white, // header background color
                        onPrimary: Colors.black, // header text color
                        onSurface: Colors.black, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              print(date);
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              print(booking);
            },
            title: const Text("What is your birthday?"),
          ),
          ListTile(
            title: const Text("Log out (IOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure"),
                  content: const Text("Please don't go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("NO"),
                    ),
                    const CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (ANDROID)"),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(
                    FontAwesomeIcons.skull,
                  ),
                  title: const Text("Are you sure"),
                  content: const Text("Please don't go"),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const FaIcon(FontAwesomeIcons.car),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (IOS / Bottom)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  message: const Text("Please dont gooooo"),
                  title: const Text("Are you sure"),
                  actions: [
                    CupertinoActionSheetAction(
                      isDefaultAction: true,
                      onPressed: () {},
                      child: const Text("Not log out"),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      isDestructiveAction: true,
                      child: const Text("Yes plz"),
                    ),
                  ],
                ),
              );
            },
          ),
          const AboutListTile(),
        ],
      ),
    );
  }
}
