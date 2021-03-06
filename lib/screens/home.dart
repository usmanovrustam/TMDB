import 'package:flutter/cupertino.dart';
import 'package:tmdb/screens/popular.dart';
import 'package:tmdb/screens/top_movies.dart';
import 'package:tmdb/screens/upcoming.dart';
import 'package:tmdb/theme/style.dart';

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  Widget buildItem(int index) {
    switch (index) {
      case 0:
        return const PopularMoviesController();
      case 1:
        return const TopMoviesController();
      case 2:
        return const UpcomingMoviesController();
      default:
        return Container();
    }
  }

  List<BottomNavigationBarItem> get tabItems => [
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.star_fill),
          label: "Popular",
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.sort_up),
          label: "Top Rated",
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bolt_fill),
          label: "Upcoming",
        ),
      ];

  CupertinoTabBar get tabBar => CupertinoTabBar(
        iconSize: 24.0,
        items: tabItems,
        activeColor: Style.colors.error,
        inactiveColor: Style.colors.white,
        backgroundColor: Style.colors.primary,
      );

  Widget get tabScaffold => CupertinoTabScaffold(
        backgroundColor: Style.colors.primary,
        tabBar: tabBar,
        tabBuilder: (_, index) => buildItem(index),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Style.colors.primary,
      child: tabScaffold,
    );
  }
}
