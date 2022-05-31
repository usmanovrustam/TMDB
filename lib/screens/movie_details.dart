import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/casts/casts.dart';
import 'package:tmdb/bloc/movies/movie.dart';
import 'package:tmdb/cells/activity_indicator.dart';
import 'package:tmdb/cells/cast_card.dart';
import 'package:tmdb/formats.dart';
import 'package:tmdb/model/cast.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/screens/cast_details.dart';
import 'package:tmdb/theme/style.dart';

class MovieDetailsController extends StatefulWidget {
  final int? id;
  const MovieDetailsController({Key? key, this.id}) : super(key: key);

  @override
  State<MovieDetailsController> createState() => _MovieDetailsControllerState();
}

class _MovieDetailsControllerState extends State<MovieDetailsController>
    with Formats {
  @override
  void initState() {
    context.read<MovieDetailsBloc>().fetchMovie(widget.id!);
    context.read<CastsBloc>().fetchCasts(widget.id!);
    super.initState();
  }

  void openDetails(Cast cast) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => CastDetails(cast: cast)),
    );
  }

  Widget name(Movie movie) => Text(
        movie.nameWithDate,
        style: Style.headline5.copyWith(
          color: Style.colors.white,
          fontSize: 32,
        ),
      );

  Widget description(Movie movie) => Text(
        movie.overview!,
        style: Style.body1.copyWith(color: Style.colors.grey400),
      );

  Widget details(String title, String value) => Text.rich(
        textAlign: TextAlign.start,
        TextSpan(
          text: "$title:\n",
          children: [
            TextSpan(
              text: value,
              style: Style.body1.copyWith(color: Style.colors.grey500),
            )
          ],
        ),
        style: Style.body18.copyWith(color: Style.colors.error),
      );

  Widget get casts => BlocBuilder<CastsBloc, CastsState>(
        builder: (context, state) {
          return state.fetching
              ? const ActivityIndicator()
              : SizedBox(
                  height: 220,
                  child: ListView.separated(
                    padding: Style.padding16.copyWith(top: 0),
                    itemCount: 10,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, index) => const SizedBox(width: 10),
                    itemBuilder: (_, index) => CastCard(
                      cast: state.data![index],
                      onTap: () => openDetails(state.data![index]),
                    ),
                  ),
                );
        },
      );

  Widget get image => BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          return Stack(
            children: [
              Image.network(state.data!.backdropImage),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: Style.padding16,
                  child: Icon(
                    CupertinoIcons.chevron_back,
                    color: Style.colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          );
        },
      );

  Widget get detailsList => BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: Style.padding16,
            children: [
              name(state.data!),
              const SizedBox(height: 2),
              description(state.data!),
              const SizedBox(height: 2),
              details("Original Name", state.data!.originalTitle!),
              const SizedBox(height: 2),
              details("Runtime", state.data!.displayRunTime),
              const SizedBox(height: 2),
              details("Rating", state.data!.voteAvgWithCount),
              const SizedBox(height: 2),
              details("Popularity", state.data!.popularity!.toString()),
              const SizedBox(height: 2),
              details("Budget", moneyFormat(state.data!.budget!.toString())),
              const SizedBox(height: 2),
              details("Revenue", moneyFormat(state.data!.revenue!.toString())),
              const SizedBox(height: 10),
              Text(
                "Casts:",
                style: Style.headline5.copyWith(color: Style.colors.white),
              ),
            ],
          );
        },
      );

  Widget get view => BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (_, state) => ListView(
          physics: const ClampingScrollPhysics(),
          children: [image, detailsList, casts],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (_, state) {
        return CupertinoPageScaffold(
          backgroundColor: Style.colors.primary,
          child: SafeArea(
            child: state.fetching
                ? const ActivityIndicator()
                : SafeArea(top: false, child: view),
          ),
        );
      },
    );
  }
}
