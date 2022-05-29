import 'package:flutter/cupertino.dart';
import 'package:tmdb/theme/style.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(
          brightness: Style.appBrightness,
        ),
        child: Center(
          child: CupertinoActivityIndicator(
            color: Style.colors.error,
            radius: 15.0,
          ),
        ),
      );
}
