import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'settings_state.g.dart';

abstract class SettingsState
    implements Built<SettingsState, SettingsStateBuilder> {
  static Serializer<SettingsState> get serializer => _$settingsStateSerializer;

  SettingsState._();
  factory SettingsState([void Function(SettingsStateBuilder) updates]) =
      _$SettingsState;

  String? get locale;

  factory SettingsState.init() => SettingsState((b) => b..locale = "en-US");
}
