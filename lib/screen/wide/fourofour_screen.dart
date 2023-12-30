import 'package:flutter/material.dart' hide ProgressIndicator;

import 'package:lobby/global_router.dart';

class FourOFourScreen extends StatelessWidget {
  static final route = buildRoute(
      key: route404,
      uri: "/404",
      route: (context) => MaterialPageRoute(
            settings: context,
            builder: (context) => const FourOFourScreen(),
          ));

  const FourOFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
