import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:tmdb/bloc/casts/cast.dart';
import 'package:tmdb/cells/activity_indicator.dart';
import 'package:tmdb/model/cast.dart';
import 'package:tmdb/theme/style.dart';

class CastDetails extends StatefulWidget {
  final Cast? cast;
  const CastDetails({Key? key, this.cast}) : super(key: key);

  @override
  State<CastDetails> createState() => _CastDetailsState();
}

class _CastDetailsState extends State<CastDetails> {
  @override
  void initState() {
    context.read<CastBloc>().fetchCast(widget.cast!.id!);
    super.initState();
  }

  Widget image(Cast cast) => Container(
        height: 500,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(cast.profileImage).image,
            fit: BoxFit.fill,
          ),
        ),
      );

  Widget get gradientDecoration => Container(
        height: 500,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Style.colors.primary,
              Style.colors.primary.withOpacity(0.3),
            ],
          ),
        ),
      );

  Widget nameWithBirtDay(Cast cast) => Padding(
        padding: Style.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cast.name!,
              style: Style.headline6.copyWith(
                color: Style.colors.white,
                fontSize: 32,
              ),
            ),
            Text(
              cast.birthYear,
              style: Style.headline6.copyWith(color: Style.colors.error),
            ),
          ],
        ),
      );

  Widget imageWithCastDetails(Cast cast) => Stack(
        alignment: Alignment.bottomLeft,
        children: [
          image(cast),
          gradientDecoration,
          nameWithBirtDay(cast),
        ],
      );

  Widget moreText(Cast cast) => Padding(
        padding: Style.padding16,
        child: ReadMoreText(
          cast.biography!,
          style: Style.body2.copyWith(color: Style.colors.white),
          trimLines: 10,
          colorClickableText: Style.colors.error,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'More',
          trimExpandedText: 'Less',
        ),
      );

  Widget details(String title, String value) => Padding(
        padding: Style.padding16.copyWith(top: 5, bottom: 5),
        child: Text.rich(
          TextSpan(
            text: "$title:\n",
            children: [
              TextSpan(
                text: value,
                style: Style.body1.copyWith(color: Style.colors.grey500),
              )
            ],
          ),
          textAlign: TextAlign.start,
          style: Style.body18.copyWith(color: Style.colors.error),
        ),
      );

  Widget get view => BlocBuilder<CastBloc, CastState>(
        builder: (context, state) => state.fetching
            ? const ActivityIndicator()
            : ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  imageWithCastDetails(state.data!),
                  moreText(state.data!),
                  details("Birthday", state.data!.birthday!),
                  details("Place of birth", state.data!.hometown!),
                  details("Popularity", state.data!.popularity!.toString()),
                  details("Also known as:", state.data!.aka!.join("\n")),
                ],
              ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Style.colors.primary,
      navigationBar: CupertinoNavigationBar(middle: Text(widget.cast!.name!)),
      child: view,
    );
  }
}
