import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:lobby/global_router.dart';

import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

class HomeScreen extends StatelessWidget {
  static final route = buildRoute(
      key: routeHome,
      uri: "/",
      route: (context) => MaterialPageRoute(
            settings: context,
            builder: (context) => const HomeScreen(),
          ));

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final assets = [
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen1.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen2.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen3.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen4.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen5.png'),
          fit: BoxFit.fill),
    ];

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Carousel(
            animationCurve: Curves.linear,
            showIndicator: false,
            autoplayDuration: const Duration(seconds: 60),
            images: assets,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                        GlobalRouter().buildUri(routeLogin)),
                    child: const Text("Login"))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
