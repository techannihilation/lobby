import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {}

class StartApp extends SettingsEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Starting App';
}

class ChangeLocale extends SettingsEvent {
  final String locale;
  ChangeLocale(this.locale);

  @override
  List<Object> get props => [locale];

  @override
  String toString() => 'Change locale to "$locale"';
}
