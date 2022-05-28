import 'package:flutter/cupertino.dart';
import 'package:tmdb/screens/home.dart';
import 'package:tmdb/theme/theme.dart';

class TMDBApp extends StatelessWidget {
  const TMDBApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: theme,
      home: const HomeController(),
    );
  }
}
