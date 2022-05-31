import 'package:flutter/cupertino.dart';
import 'package:tmdb/cells/gradient_card.dart';
import 'package:tmdb/model/cast.dart';
import 'package:tmdb/theme/style.dart';

class CastCard extends StatelessWidget {
  final Function()? onTap;
  final Cast? cast;
  const CastCard({Key? key, this.onTap, this.cast}) : super(key: key);

  Widget get footer => Container(
        height: 60,
        width: 140,
        color: Style.colors.darkPrimary,
        child: Padding(
          padding: Style.padding8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  cast!.name!,
                  maxLines: 1,
                  style: Style.body2.copyWith(
                    color: Style.colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  cast!.character!,
                  maxLines: 1,
                  style: Style.body2.copyWith(
                    color: Style.colors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get image => SizedBox(
        width: 140,
        child: cast?.profilePath != null
            ? Image.network(cast!.profileImage, fit: BoxFit.fill)
            : Container(),
      );

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [image, footer],
      ),
    );
  }
}
