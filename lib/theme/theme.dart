import 'package:event_management_app/theme/widget_themes/elevated_button_theme.dart';
import 'package:event_management_app/theme/widget_themes/outlined_button_theme.dart';
import 'package:event_management_app/theme/widget_themes/text_field_theme.dart';
import 'package:event_management_app/theme/widget_themes/text_theme.dart';
import 'package:event_management_app/utility/color_constants.dart';
import 'package:flutter/material.dart';



class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    scaffoldBackgroundColor: AppColors.white,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
}
