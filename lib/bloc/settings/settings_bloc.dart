import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import "package:gettext/gettext.dart";
import 'package:gettext_parser/gettext_parser.dart' as gettextParser;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/date_symbol_data_local.dart';
import 'settings_state.dart';
import 'settings_event.dart';
import '../serializers.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with HydratedMixin {
  final Gettext gt;

  SettingsBloc({required this.gt}) : super(SettingsState.init()) {
    hydrate();

    on<StartApp>((event, emit) async {});

    on<ChangeLocale>((event, emit) async {
      await setLocale(event.locale);

      emit(state.rebuild((b) => b..locale = event.locale));
    });
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    var myState = serializers.deserializeWith(SettingsState.serializer, json);

    if (myState != null && myState.locale != null) {
      unawaited(() async {
        await setLocale(myState.locale!);
      }.call());
    }

    return myState;
  }

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    return serializers.serializeWith(SettingsState.serializer, state)
        as Map<String, dynamic>;
  }

  Future<void> setLocale(String locale) async {
    Intl.defaultLocale = locale;
    await initializeDateFormatting(locale);

    try {
      final data = await rootBundle.loadString("assets/i18n/$locale.po");
      gt.addLocale(gettextParser.po.parse(data));
      gt.locale = locale;
    } on FlutterError {
      debugPrint("Failed to load locale $locale");
    }
  }
}
