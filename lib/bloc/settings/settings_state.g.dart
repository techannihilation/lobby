// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SettingsState> _$settingsStateSerializer =
    new _$SettingsStateSerializer();

class _$SettingsStateSerializer implements StructuredSerializer<SettingsState> {
  @override
  final Iterable<Type> types = const [SettingsState, _$SettingsState];
  @override
  final String wireName = 'SettingsState';

  @override
  Iterable<Object?> serialize(Serializers serializers, SettingsState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.locale;
    if (value != null) {
      result
        ..add('locale')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SettingsState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'locale':
          result.locale = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$SettingsState extends SettingsState {
  @override
  final String? locale;

  factory _$SettingsState([void Function(SettingsStateBuilder)? updates]) =>
      (new SettingsStateBuilder()..update(updates))._build();

  _$SettingsState._({this.locale}) : super._();

  @override
  SettingsState rebuild(void Function(SettingsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsStateBuilder toBuilder() => new SettingsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsState && locale == other.locale;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SettingsState')
          ..add('locale', locale))
        .toString();
  }
}

class SettingsStateBuilder
    implements Builder<SettingsState, SettingsStateBuilder> {
  _$SettingsState? _$v;

  String? _locale;
  String? get locale => _$this._locale;
  set locale(String? locale) => _$this._locale = locale;

  SettingsStateBuilder();

  SettingsStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _locale = $v.locale;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SettingsState;
  }

  @override
  void update(void Function(SettingsStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SettingsState build() => _build();

  _$SettingsState _build() {
    final _$result = _$v ?? new _$SettingsState._(locale: locale);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
