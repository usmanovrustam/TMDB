import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/cells/gradient_card.dart';
import 'package:tmdb/theme/style.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key}) : super(key: key);

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
          borderRadius: Style.border8,
          child: Image.network(
            "https://image.tmdb.org/t/p/w500//q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget get body => Expanded(
        flex: 5,
        child: Padding(
          padding: Style.padding12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Spider Man",
                  style: Style.headline6.copyWith(
                    color: Style.colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              text("Released at: ", '1994-09-23'),
              const SizedBox(height: 8),
              text("Ganres: ", 'Epic, Tragedy, Comedy'),
              const SizedBox(height: 8),
              text("Vote: ", '8.7 (21470)'),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      child: SizedBox(
        height: 140,
        child: Row(children: [image, body]),
      ),
    );
  }
}
