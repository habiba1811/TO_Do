import 'package:flutter/material.dart';
import 'package:to_do/styles/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(

      scaffoldBackgroundColor: mintGreen,

      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: primary,
          unselectedItemColor: const Color(0xFFC8C9CB)));
  static ThemeData darkTheme = ThemeData();
}
