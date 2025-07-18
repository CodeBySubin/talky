import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talky/features/users/domain/usecase/user_usecase.dart';
import 'package:talky/features/users/presentation/bloc/user_event.dart';
import 'package:talky/features/users/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserSatate> {
  final FetchUsers _fetchUsers;
  final dio = Dio();
  UserBloc(this._fetchUsers) : super(const UserSatate.initial()) {
    on<GetUSers>(_getUsers);
  }

  Future<void> _getUsers(GetUSers event, Emitter<UserSatate> emit) async {
    emit(UserSatate.loading());
    final users = await _fetchUsers();
    final res = await dio.get(
        'https://test-api-4u0w.onrender.com/rtc/testchannel/publisher/${event.uid}',
      );
      if (res.statusCode == 200) {
        final token = res.data['token'];
    emit(UserSatate.loaded(users,token));
  }
  }
}
