import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/movies/movie.dart';
import 'package:tmdb/bloc/movies/popular.dart';
import 'package:tmdb/bloc/movies/top_rated.dart';
import 'package:flutter/material.dart' show DefaultMaterialLocalizations;
import 'package:tmdb/bloc/movies/upcoming.dart';
import 'package:tmdb/screens/home.dart';
import 'package:tmdb/theme/theme.dart';

class TMDBApp extends StatelessWidget {
  const TMDBApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TopRatedBloc()),
        BlocProvider(create: (context) => PopularBloc()),
        BlocProvider(create: (context) => UpcomingBloc()),
        BlocProvider(create: (context) => MovieDetailsBloc()),
      ],
      child: CupertinoApp(
        theme: theme,
        home: const HomeController(),
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
