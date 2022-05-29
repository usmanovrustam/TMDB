import 'package:flutter/cupertino.dart';
import 'package:tmdb/bloc/movies/top_rated.dart';
import 'package:tmdb/cells/activity_indicator.dart';
import 'package:tmdb/cells/movie_card.dart';
import 'package:tmdb/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/utils/constants.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  void initState() {
    context.read<TopRatedBloc>().fetchMovies(1);
    super.initState();
  }

  bool onScrollNotification(ScrollUpdateNotification notification) {
    final scrollArea = notification.metrics.maxScrollExtent;
    final scrolled = notification.metrics.pixels;
    final scrollLeft = scrollArea - scrolled;
    final cubit = context.read<TopRatedBloc>();

    if (scrollLeft < BOTTOM_FETCH_THR &&
        !cubit.state.fetching &&
        !cubit.state.hasException &&
        !notification.metrics.outOfRange) {
      cubit.fetchMovies(cubit.state.data!.page! + 1);
    }

    return false;
  }

  Widget get view => BlocBuilder<TopRatedBloc, TopRatedState>(
        builder: (context, state) {
          return state.fetching && state.data == null
              ? const ActivityIndicator()
              : NotificationListener(
                  onNotification: onScrollNotification,
                  child: ListView.separated(
                    padding: Style.padding16,
                    separatorBuilder: (_, index) => const SizedBox(height: 10),
                    itemCount:
                        state.data!.objects!.length + (state.fetching ? 1 : 0),
                    itemBuilder: (_, index) =>
                        (index >= state.data!.objects!.length)
                            ? const ActivityIndicator()
                            : MovieCard(movie: state.data!.objects![index]),
                  ),
                );
        },
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Style.colors.primary,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Style.colors.primary,
        automaticallyImplyLeading: false,
        middle: Text(
          "Popular Movies",
          style: Style.headline6.copyWith(color: Style.colors.white),
        ),
      ),
      child: SafeArea(child: view),
    );
  }
}
