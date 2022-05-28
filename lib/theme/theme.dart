import 'package:flutter/cupertino.dart';
import 'package:tmdb/theme/style.dart';

final theme = CupertinoThemeData(
  brightness: Style.appBrightness,
  primaryColor: Style.colors.black,
  scaffoldBackgroundColor: Style.colors.background,
  barBackgroundColor: Style.colors.background,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(fontFamily: Style.fontFamily),
    navActionTextStyle: TextStyle(color: Style.colors.black),
    navTitleTextStyle: Style.headline6,
  ),
);
