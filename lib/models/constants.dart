import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData(
      primaryColor: Colors.amber,
      backgroundColor: Colors.white,
      brightness: Brightness.light);

  static final dark = ThemeData(
      primaryColor: Colors.black,
      backgroundColor: Colors.black,
      brightness: Brightness.dark);

  static TextStyle get StyleOne {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color:Get.isDarkMode?Colors.black:Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500));
  }

  static TextStyle get StyleTwo {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : Color(0xff86abf9),
            fontSize: 15));
  }

  static TextStyle get StyleThree {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color:Get.isDarkMode?Colors.black:Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold));
  }
  static TextStyle get StyleFour {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color:Get.isDarkMode?Colors.white:Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold));
  }
}

