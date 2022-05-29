import 'package:flutter/material.dart';
import 'package:tmdb/theme/style.dart';

class GradientCard extends StatelessWidget {
  final Widget? child;
  final Gradient? gradient;
  final Function()? onTap;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;
  final bool roundedBorders;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  const GradientCard({
    required this.child,
    this.onTap,
    this.gradient,
    this.contentPadding,
    this.margin,
    this.roundedBorders = true,
    this.backgroundColor,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  BorderRadius get radius =>
      roundedBorders ? (borderRadius ?? Style.border8) : BorderRadius.zero;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 6.0,
        shadowColor: Style.colors.black,
        margin: margin ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: radius),
        child: ClipRRect(
          borderRadius: radius,
          child: Material(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: contentPadding,
                decoration: BoxDecoration(
                  color: backgroundColor ?? Style.colors.darkPrimary,
                ),
                child: child,
              ),
            ),
          ),
        ),
      );
}
