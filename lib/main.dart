import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import "package:gettext/gettext.dart";

import 'package:lobby/global_router.dart';
import 'package:lobby/global_bloc_observer.dart';
import 'package:lobby/bloc/settings/settings.dart';
import 'package:lobby/bloc/user/user.dart';
import 'package:lobby/screen/wide/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  registerWideRoutes();

  final packageInfo = await PackageInfo.fromPlatform();
  final gt = Gettext(onWarning: debugPrint);

  final sBloc = SettingsBloc(gt: gt);

  if (kDebugMode) {
    Bloc.observer = GlobalBlocObserver();
  }
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: packageInfo),
        RepositoryProvider.value(value: gt),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>.value(value: sBloc..add(StartApp())),
          BlocProvider<UserBloc>(create: (context) => UserBloc()),
        ],
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'TechA Lobby',
        theme: ThemeData(
          fontFamily: "Klavika",
          primaryTextTheme:
              Theme.of(context).primaryTextTheme.apply(fontFamily: "Klavika"),
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: "Klavika",
              bodyColor: Colors.white,
              displayColor: Colors.white),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black87,
          colorScheme: const ColorScheme.dark().copyWith(
              primaryContainer: Colors.black87,
              secondaryContainer: Colors.white),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            iconSize: 38.0,
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: (routeContext) =>
            GlobalRouter().generateRoute(routeContext),
      );
    });
  }
}
