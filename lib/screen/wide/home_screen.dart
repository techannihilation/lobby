import 'package:flutter/material.dart' hide ProgressIndicator;

import 'package:lobby/global_router.dart';
import 'package:lobby/bloc/settings/settings_state.dart';
import 'package:lobby/screen/wide/base_fullscreen.dart';

class HomeScreen extends BaseFullscreen {
  static final route = buildRoute(
      key: routeHome,
      uri: "/",
      route: (context) => MaterialPageRoute(
            settings: context,
            builder: (context) => const HomeScreen(),
          ));

  const HomeScreen({super.key});

  @override
  Widget content(BuildContext context, SettingsState state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(GlobalRouter().buildUri(routeLogin)),
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
