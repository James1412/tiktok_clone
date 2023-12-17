import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TikTok Clone",
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(
              fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          displayMedium: GoogleFonts.openSans(
              fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          displaySmall:
              GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
          headlineMedium: GoogleFonts.openSans(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headlineSmall:
              GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
          titleLarge: GoogleFonts.openSans(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          titleMedium: GoogleFonts.openSans(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          titleSmall: GoogleFonts.openSans(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyLarge: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyMedium: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          labelLarge: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          bodySmall: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          labelSmall: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        )
        // Press and long press colors to transparent to have no splash effect
        ,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade50,
        ),
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}
