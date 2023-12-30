import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'user_state.dart';
import 'user_event.dart';
import '../serializers.dart';

class UserBloc extends Bloc<UserEvent, UserState> with HydratedMixin {
  UserBloc() : super(UserState.init()) {
    hydrate();

    on<SetUsername>((event, emit) async {
      emit(state.rebuild((b) => b..name = event.name));
    });
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserState.serializer, json);
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    return serializers.serializeWith(UserState.serializer, state)
        as Map<String, dynamic>;
  }
}
