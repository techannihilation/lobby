import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const routeLogin = 'login';
const routeHome = 'home';
const route404 = '404';

typedef RouteBuilder = Route<dynamic> Function(RouteSettings context);

class BuildError implements Exception {
  final String message;
  BuildError(this.message);

  @override
  String toString() => message;
}

abstract class GlobalRoute {
  String get key;
  RouteBuilder get route;
  bool matchesRoute(String route);
  Map<String, String> extractNamedArgs(BuildContext context);
  String buildUri({Map<String, String>? buildArgs});
}

class ExactRoute implements GlobalRoute {
  @override
  final String key;
  final String uri;
  @override
  final RouteBuilder route;

  ExactRoute({required this.key, required this.uri, required this.route});

  @override
  bool matchesRoute(String route) => route == uri;

  @override
  Map<String, String> extractNamedArgs(BuildContext context) => {};

  @override
  String buildUri({Map<String, String>? buildArgs}) {
    assert(buildArgs == null);
    return uri;
  }
}

class NamedArgsRoute implements GlobalRoute {
  @override
  final String key;
  final String builderUri;
  final RegExp regex;
  final Map<String, int> args;
  @override
  final RouteBuilder route;
  final bool lastArgOptional;

  NamedArgsRoute(
      {required this.key,
      required this.builderUri,
      required this.regex,
      required this.args,
      required this.route,
      this.lastArgOptional = false});

  @override
  bool matchesRoute(String route) {
    return regex.hasMatch(route);
  }

  @override
  Map<String, String> extractNamedArgs(BuildContext context) {
    var uri = ModalRoute.of(context)!.settings.name;
    if (uri == null || !matchesRoute(uri)) {
      return {};
    }

    final match = regex.firstMatch(uri);

    Map<String, String> result = {};
    for (var name in args.keys) {
      if (match != null &&
          match.groupCount >= args[name]! &&
          match.group(args[name]!) != null) {
        result[name] = Uri.decodeComponent(match.group(args[name]!)!);
      }
    }

    return result;
  }

  @override
  String buildUri({Map<String, String>? buildArgs}) {
    if (buildArgs == null && lastArgOptional && args.length == 1) {
      return builderUri.replaceFirst(r'/{' + args.keys.first + r'}', "");
    } else if (buildArgs == null) {
      throw BuildError("BuildArgs are not optional for route '$key'");
    }

    if (lastArgOptional && buildArgs.keys.length < args.keys.length - 1) {
      throw BuildError("Not all args given for route '$key'");
    } else if (buildArgs.keys.length < args.keys.length) {
      throw BuildError("Not all args given for route '$key'");
    }

    var result = builderUri;
    for (var argName in buildArgs.keys) {
      result = result.replaceAll(
          '{$argName}', Uri.encodeComponent(buildArgs[argName]!));
    }

    if (lastArgOptional && result.contains('{')) {
      result = result.replaceFirst(RegExp(r"(\/?\{\S+\})$"), "");
    }

    return result;
  }
}

GlobalRoute buildRoute(
    {required String key,
    required String uri,
    bool lastArgOptional = false,
    required RouteBuilder route}) {
  var matches = RegExp(r"\{(\w+)\}").allMatches(uri);
  if (!matches.isNotEmpty) {
    return ExactRoute(key: key, uri: uri, route: route);
  }

  Map<String, int> args = {};
  var regex = r'^' + uri.replaceAll("/", r"\/") + r'$';

  var i = 1;
  for (var match in matches) {
    if (lastArgOptional && i == matches.length) {
      regex = regex.replaceFirst(
          r'\/{' + match.group(1)! + r'}', r"((\/([^\/]+))?)\/?");
      args[match.group(1)!] = i + 2;
      break;
    }

    regex = regex.replaceFirst('{${match.group(1)}}', r"([^\/]+)");
    args[match.group(1)!] = i;

    i++;
  }

  return NamedArgsRoute(
      key: key,
      builderUri: uri,
      regex: RegExp(regex),
      args: args,
      route: route,
      lastArgOptional: lastArgOptional);
}

class GlobalRouter {
  Map<String, GlobalRoute> routes = {};
  List<GlobalRoute> dynamicRoutes = [];
  Map<String, ExactRoute> exactRoutes = {};

  final List<String> requiredRoutes = [
    routeLogin,
    routeHome,
    route404,
  ];

  static final GlobalRouter _singleton = GlobalRouter._internal();
  GlobalRouter._internal();

  factory GlobalRouter() {
    return _singleton;
  }

  bool validateRoutes() {
    for (var name in requiredRoutes) {
      if (!routes.containsKey(name)) {
        continue;
      }
    }

    return true;
  }

  void clear() {
    routes.clear();
    exactRoutes.clear();
    dynamicRoutes.clear();
  }

  void add<T extends GlobalRoute>(T route) {
    routes[route.key] = route;
    if (route is ExactRoute) {
      exactRoutes[route.uri] = route;
    } else {
      dynamicRoutes.add(route);
    }
  }

  String buildUri(String key, {Map<String, String>? buildArgs}) {
    return routes[key]!.buildUri(buildArgs: buildArgs);
  }

  Map<String, String> extractNamedArgs(BuildContext context, String key) {
    return routes[key]!.extractNamedArgs(context);
  }

  bool isCurrentRoute(BuildContext context, String key) {
    return routes[key]!.matchesRoute(ModalRoute.of(context)!.settings.name!);
  }

  Route<dynamic> generateRoute(RouteSettings context) {
    if (kDebugMode) {
      debugPrint("Generating route for '${context.name}'");
    }

    if (exactRoutes.containsKey(context.name)) {
      if (kDebugMode) {
        debugPrint("... found route: ${context.name}");
      }
      return exactRoutes[context.name]!.route(context);
    }

    for (var route in dynamicRoutes) {
      if (route.matchesRoute(context.name!)) {
        debugPrint("... found route: ${route.key}");
        return route.route(context);
      }
    }

    debugPrint("... going to 404");
    return routes[route404]!.route(context);
  }
}
