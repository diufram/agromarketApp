// FONTS

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//const String baseURL = "http://137.184.196.1/";

const String baseURL = "http://192.168.0.10:8000/";

const brackground = Color.fromRGBO(192, 57, 43, 100);

ThemeData poppins = ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
        displayLarge:
            GoogleFonts.poppins(textStyle: TextStyle(fontSize: 45.sp)),
        titleLarge: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20.sp)),
        titleMedium: GoogleFonts.poppins(),
        bodyLarge: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 12.sp)),
        bodySmall: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 9.sp)),
        labelMedium: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 13.sp,
        )),
        bodyMedium: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 11.sp)),
        labelLarge: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 15.sp,
        ))));

const Map<String, String> headers = {"Content-Type": "application/json"};
