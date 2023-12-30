import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'settings/settings_state.dart';
import 'user/user_state.dart';

part 'serializers.g.dart';

@SerializersFor([
  SettingsState,
  UserState,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
