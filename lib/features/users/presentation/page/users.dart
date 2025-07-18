import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talky/core/routes/routes.dart';
import 'package:talky/core/utils/secure_storage.dart';
import 'package:talky/di/dependency_injection.dart';
import 'package:talky/features/users/domain/usecase/user_usecase.dart';
import 'package:talky/features/users/presentation/bloc/user_state.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    String? uid = await SecureStorageHelper.getToken('user');
    context.read<UserBloc>().add(UserEvent.getUsers(int.parse(uid!)));

    // if (uid != null) {
    //   context.read<UserBloc>().add(UserEvent.token(int.parse(uid)));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: BlocBuilder<UserBloc, UserSatate>(
        builder: (context, state) {
          return state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded:
                    (users, token) => ListView.builder(
                      itemCount: users.length,
                      itemBuilder:
                          (_, i) => ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(users[i].name),
                                Container(
                                  color: Colors.amber,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        RouteNames.chat,
                                        pathParameters: {
                                          'userId': users[i].phone,
                                        },
                                      );
                                    },
                                    child: Icon(Icons.call),
                                  ),
                                ),
                                Container(
                                  color: Colors.amber,
                                  child: GestureDetector(
                                    onTap: () async {
                                      String? uid =
                                          await SecureStorageHelper.getToken(
                                            'user',
                                          );
                                      context.pushNamed(
                                        RouteNames.videoCall,
                                        extra: {
                                          'channel': 'testchannel',
                                          'token': token,
                                          'uid': int.parse(uid!),
                                        },
                                      );
                                    },
                                    child: Icon(Icons.video_call),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(users[i].phone),
                          ),
                    ),
                // error: (message) => Center(child: Text("Error: $message")),
              ) ??
              const SizedBox.shrink();
        },
      ),
    );
  }
}
