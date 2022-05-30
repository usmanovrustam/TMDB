import 'package:flutter/cupertino.dart';
import 'package:tmdb/bloc/movies/top_rated.dart';
import 'package:tmdb/cells/activity_indicator.dart';
import 'package:tmdb/cells/movie_card.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/screens/details.dart';
import 'package:tmdb/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/utils/constants.dart';

class TopMoviesController extends StatefulWidget {
  const TopMoviesController({Key? key}) : super(key: key);

  @override
  State<TopMoviesController> createState() => _TopMoviesControllerState();
}

class _TopMoviesControllerState extends State<TopMoviesController> {
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

  void openDetails(Movie movie) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => MovieDetailsController(id: movie.id)),
    );
  }

  Widget get view => BlocBuilder<TopRatedBloc, TopRatedState>(
        builder: (context, state) {
          return state.fetching && state.data == null
              ? const ActivityIndicator()
              : NotificationListener(
                  onNotification: onScrollNotification,
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    padding: Style.padding16,
                    separatorBuilder: (_, index) => const SizedBox(height: 10),
                    itemCount:
                        state.data!.objects!.length + (state.fetching ? 1 : 0),
                    itemBuilder: (_, index) =>
                        (index >= state.data!.objects!.length)
                            ? const ActivityIndicator()
                            : MovieCard(
                                movie: state.data!.objects![index],
                                onTap: () =>
                                    openDetails(state.data!.objects![index]),
                              ),
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
          "Top Rated Movies",
          style: Style.headline6.copyWith(color: Style.colors.white),
        ),
      ),
      child: SafeArea(child: view),
    );
  }
}
