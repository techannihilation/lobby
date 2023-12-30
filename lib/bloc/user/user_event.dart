import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class SetUsername extends UserEvent {
  final String name;
  SetUsername(this.name);

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'Setting the username to $name';
}
