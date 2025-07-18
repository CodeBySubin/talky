// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent()';
}


}

/// @nodoc
class $UserEventCopyWith<$Res>  {
$UserEventCopyWith(UserEvent _, $Res Function(UserEvent) __);
}


/// Adds pattern-matching-related methods to [UserEvent].
extension UserEventPatterns on UserEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( GetUSers value)?  getUsers,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case GetUSers() when getUsers != null:
return getUsers(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( GetUSers value)  getUsers,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case GetUSers():
return getUsers(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( GetUSers value)?  getUsers,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case GetUSers() when getUsers != null:
return getUsers(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int uid)?  getUsers,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case GetUSers() when getUsers != null:
return getUsers(_that.uid);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int uid)  getUsers,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case GetUSers():
return getUsers(_that.uid);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int uid)?  getUsers,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case GetUSers() when getUsers != null:
return getUsers(_that.uid);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements UserEvent {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent.initial()';
}


}




/// @nodoc


class GetUSers implements UserEvent {
  const GetUSers(this.uid);
  

 final  int uid;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetUSersCopyWith<GetUSers> get copyWith => _$GetUSersCopyWithImpl<GetUSers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUSers&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,uid);

@override
String toString() {
  return 'UserEvent.getUsers(uid: $uid)';
}


}

/// @nodoc
abstract mixin class $GetUSersCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory $GetUSersCopyWith(GetUSers value, $Res Function(GetUSers) _then) = _$GetUSersCopyWithImpl;
@useResult
$Res call({
 int uid
});




}
/// @nodoc
class _$GetUSersCopyWithImpl<$Res>
    implements $GetUSersCopyWith<$Res> {
  _$GetUSersCopyWithImpl(this._self, this._then);

  final GetUSers _self;
  final $Res Function(GetUSers) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = null,}) {
  return _then(GetUSers(
null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
