import 'package:flutter/cupertino.dart';
import 'package:tmdb/cells/movie_card.dart';
import 'package:tmdb/theme/style.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({Key? key}) : super(key: key);

  Widget get view => ListView.separated(
        padding: Style.padding16,
        itemBuilder: (_, index) => const MovieCard(),
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemCount: 3,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: view);
  }
}
