import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static final lightTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 209, 196, 233),
      colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 209, 196, 233),
          secondary: Color(0xFFD1C4E9),
          onPrimary: Colors.black,
          background: Colors.white38),
      textTheme: textTheme(),
      outlinedButtonTheme: outlinedButtonThemeData(),
      cardTheme: cardTheme());
}

TextTheme textTheme() {
  return GoogleFonts.comfortaaTextTheme();
}

OutlinedButtonThemeData outlinedButtonThemeData() {
  return OutlinedButtonThemeData(
      style: ButtonStyle(
    textStyle: MaterialStateProperty.all(
      TextStyle(foreground: Paint()..color = Colors.black),
    ),
    shape: MaterialStateProperty.all(
        ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))),
  ));
}

CardTheme cardTheme() {
  return CardTheme(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
}
