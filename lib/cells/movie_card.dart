import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/cells/gradient_card.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/theme/style.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie;
  final Function()? onTap;
  const MovieCard({Key? key, this.movie, this.onTap}) : super(key: key);

  Widget text(String title, String text) => Expanded(
        child: Text.rich(
          textAlign: TextAlign.start,
          TextSpan(
            text: title,
            children: [
              TextSpan(
                text: text,
                style: Style.body2.copyWith(color: Style.colors.grey500),
              )
            ],
          ),
          style: Style.body2.copyWith(
            color: Style.colors.error,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget get image => Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: Style.border10,
          child: Image.network(movie!.posterImage, fit: BoxFit.cover),
        ),
      );

  Widget get body => Expanded(
        flex: 5,
        child: Padding(
          padding: Style.padding12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie!.nameWithDate,
                maxLines: 2,
                style: Style.headline6.copyWith(
                  color: Style.colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              text("Name: ", movie!.title!),
              const SizedBox(height: 2),
              text("Genres: ", movie!.genres.join(",")),
              const SizedBox(height: 2),
              text("Vote: ", movie!.voteAvgWithCount),
              const SizedBox(height: 2),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      onTap: onTap,
      child: SizedBox(
        height: 140,
        child: Row(children: [image, body]),
      ),
    );
  }
}
