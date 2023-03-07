import 'package:clocks/const/color_constants.dart';
import 'package:clocks/views/pages/clock_page.dart';
import 'package:clocks/views/widgets/analog_clock/analog_clock_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.roboto(fontSize: 92.0, color: ColorConstants.main),
          displayMedium: GoogleFonts.roboto(fontSize: 44.0, color: ColorConstants.main),
          displaySmall: GoogleFonts.roboto(fontSize: 24.0, color: ColorConstants.main),
          headlineLarge: GoogleFonts.roboto(color: ColorConstants.main),
          headlineMedium: GoogleFonts.roboto(color: ColorConstants.main),
          headlineSmall: GoogleFonts.roboto(color: ColorConstants.main),
          bodyLarge: GoogleFonts.roboto(color: ColorConstants.main),
          bodySmall: GoogleFonts.roboto(color: ColorConstants.main),
          labelLarge: GoogleFonts.roboto(color: ColorConstants.main),
          labelMedium: GoogleFonts.roboto(color: ColorConstants.main),
          labelSmall: GoogleFonts.roboto(color: ColorConstants.main),
        ),
      ),
      home: Scaffold(
        body: ClockPage(),
      ),
    );
  }
}
