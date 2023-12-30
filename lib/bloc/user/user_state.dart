import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_state.g.dart';

abstract class UserState implements Built<UserState, UserStateBuilder> {
  static Serializer<UserState> get serializer => _$userStateSerializer;

  UserState._();
  factory UserState([void Function(UserStateBuilder) updates]) = _$UserState;

  String? get name;

  factory UserState.init() => UserState((b) => b);
}
