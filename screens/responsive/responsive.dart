import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key, required this.mobileView, required this.tabletView});
  final Widget mobileView;
  final Widget tabletView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 750) {
          return mobileView;
        } else {
          return tabletView;
        }
      },
    );
  }
}
