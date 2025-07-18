
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent{
  const factory UserEvent.initial() = Initial;
  const factory UserEvent.getUsers(int uid) = GetUSers;

}