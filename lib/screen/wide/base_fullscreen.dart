import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

import 'package:lobby/bloc/settings/settings.dart';

abstract class BaseFullscreen extends StatelessWidget {
  const BaseFullscreen({super.key});

  Widget content(BuildContext context, SettingsState state);

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

    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      final packageInfo = RepositoryProvider.of<PackageInfo>(context);

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
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "${packageInfo.appName} ${packageInfo.version}-${packageInfo.buildNumber} (${Theme.of(context).platform.name})",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          content(context, state),
        ],
      );
    });
  }
}
