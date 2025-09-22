import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_stack/di/di_setup.dart';
import 'package:string_stack/presentation/start/start_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          disabledElevation: 0,
          shape: CircleBorder(),
          backgroundColor: Color(0xFF03071e),
          foregroundColor: Colors.white,
        ),
        textTheme: GoogleFonts.nunitoTextTheme().copyWith(
          headlineLarge: GoogleFonts.nunito().copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0d1b2a)),
      ),
      home: StartScreen(),
    );
  }
}
