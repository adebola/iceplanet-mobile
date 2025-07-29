import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';

class LightTheme {
  ThemeData lightTheme(context) => ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.groceryWhite,
      );
}
