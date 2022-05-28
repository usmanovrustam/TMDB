import 'package:flutter/cupertino.dart';
import 'package:tmdb/theme/colors.dart';

class Style {
  /// Application Colors
  static AppColors get colors => const AppColors();

  /// Brightness of the app
  static Brightness get appBrightness => Brightness.light;

  /// Border radius templates

  static BorderRadius get border8 => const BorderRadius.all(
        Radius.circular(8.0),
      );

  /// Padding templates
  static EdgeInsets get padding1 => const EdgeInsets.all(1.0);

  static EdgeInsets get padding4 => const EdgeInsets.all(4.0);

  static EdgeInsets get padding8 => const EdgeInsets.all(8.0);

  static EdgeInsets get padding12 => const EdgeInsets.all(12.0);

  static EdgeInsets get padding16 => const EdgeInsets.all(16.0);

  static EdgeInsets get padding20 => const EdgeInsets.all(20.0);

  static EdgeInsets get padding32 => const EdgeInsets.all(32.0);

  /// Margin templates
  static EdgeInsets get margin20 => padding20;

  /// Typography
  static String get fontFamily => "Inter";

  static TextStyle get headline5 => TextStyle(
        fontSize: 24.0,
        letterSpacing: 0.15,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get headline5Orange => TextStyle(
        fontSize: 24.0,
        letterSpacing: 0.0,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get headline6 => TextStyle(
        fontSize: 20.0,
        letterSpacing: 0.15,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get subtitle1 => TextStyle(
        fontSize: 16.0,
        letterSpacing: 0.15,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get dynamicSubtitle => TextStyle(
        letterSpacing: 0.15,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get body18 => TextStyle(
        fontSize: 18.0,
        letterSpacing: 0.15,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  static TextStyle get subtitle2 => TextStyle(
        fontSize: 14.0,
        letterSpacing: 0.15,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get subtitle2White => TextStyle(
        fontSize: 14.0,
        letterSpacing: 0.1,
        color: colors.white,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get button => TextStyle(
        fontSize: 14.0,
        letterSpacing: 1.25,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get body1 => TextStyle(
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get body2 => TextStyle(
        fontSize: 14.0,
        letterSpacing: 0.25,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get caption => TextStyle(
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: colors.black,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w300,
      );
}
