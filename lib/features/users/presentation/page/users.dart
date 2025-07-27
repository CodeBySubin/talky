import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talky/core/routes/routes.dart';
import 'package:talky/core/utils/secure_storage.dart';
import 'package:talky/features/users/presentation/bloc/user_bloc.dart';
import 'package:talky/features/users/presentation/bloc/user_event.dart';
import 'package:talky/features/users/presentation/bloc/user_state.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? currentUserPhone;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    String? phone = await SecureStorageHelper.getToken('user');
print("phoneeeeeeeeee${phone}");
    if (phone != null) {
      setState(() {
        currentUserPhone = phone;
      });

      context.read<UserBloc>().add(UserEvent.getUsers(int.parse(phone)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: BlocBuilder<UserBloc, UserSatate>(
        builder: (context, state) {
          return state.whenOrNull(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (users, token) {
                  final filteredUsers = users
                      .where((user) => user.phone != currentUserPhone)
                      .toList();

                  if (filteredUsers.isEmpty) {
                    return const Center(child: Text("No other users found"));
                  }

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (_, i) {
                      final user = filteredUsers[i];
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(user.name),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      RouteNames.chat,
                                      pathParameters: {'userId': user.phone},
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      RouteNames.videoCall,
                                      extra: {
                                        'rid': int.parse(user.phone.substring(0,6)),
                                        'token': token,
                                        'uid': int.parse(currentUserPhone!.substring(0,6)),
                                      },
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Icon(
                                      Icons.video_call,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Text(user.phone),
                      );
                    },
                  );
                },
              ) ??
              const SizedBox.shrink();
        },
      ),
    );
  }
}
