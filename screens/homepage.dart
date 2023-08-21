import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:tsmcd_dp/screens/responsive/mobileView.dart';
import 'package:tsmcd_dp/screens/responsive/responsive.dart';
import 'package:tsmcd_dp/screens/responsive/tabletView.dart';
import 'package:tsmcd_dp/utils/constants.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Responsive(
      mobileView: MobileView(),
      tabletView: TabletView(),
    );
  }
}
