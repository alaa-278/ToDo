import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class ThemesStyle {
  static final light = ThemeData(
      primaryColor: Colors.amber,
      backgroundColor: Colors.white,
      brightness: Brightness.light);

  static final dark = ThemeData(
      primaryColor: Colors.black,
      backgroundColor: Colors.black,
      brightness: Brightness.dark);

  TextStyle get StyleOne {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Lato',
            fontSize: 20,
            fontWeight: FontWeight.w500));
  }

  TextStyle get StyleTwo {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Color(0xff86abf9),
            fontFamily: 'Lato',
            fontSize: 15));
  }

  TextStyle get StyleThree {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Lato',
            fontSize: 15,
            fontWeight: FontWeight.bold));
  }
}
