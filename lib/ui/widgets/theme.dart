import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light =
      // ignore: deprecated_member_use
      ThemeData(
          primaryColor: primaryClr,
          backgroundColor: Colors.white,
          brightness: Brightness.light);
  static final dark =
      // ignore: deprecated_member_use
      ThemeData(
          primaryColor: darkGreyClr,
          backgroundColor: darkGreyClr,
          brightness: Brightness.dark);
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : darkGreyClr));
}

TextStyle get SubheadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : darkGreyClr));
}

TextStyle get TitleStyleheadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : darkGreyClr));
}

TextStyle get SubtitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : darkGreyClr));
}

TextStyle get bodygStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : darkGreyClr));
}

TextStyle get bodygStyle2 {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[200] : darkGreyClr));
}
