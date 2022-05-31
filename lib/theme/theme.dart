import 'package:flutter/cupertino.dart';
import 'package:tmdb/theme/style.dart';

final theme = CupertinoThemeData(
  brightness: Style.appBrightness,
  primaryColor: Style.colors.primary,
  scaffoldBackgroundColor: Style.colors.primary,
  barBackgroundColor: Style.colors.primary,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(fontFamily: Style.fontFamily),
    navActionTextStyle: TextStyle(color: Style.colors.white),
    navTitleTextStyle: Style.headline6.copyWith(color: Style.colors.white),
  ),
);
