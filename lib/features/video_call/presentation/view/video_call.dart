import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../bloc/video_call_bloc.dart';
import '../bloc/video_call_events.dart';
import '../bloc/video_call_states.dart';
import '../../../../core/constants/app_color.dart';

class VideoCall extends StatefulWidget {
  final String channel;
  final String token;
  final int uid;

  const VideoCall({
    required this.channel,
    required this.token,
    required this.uid,
    super.key,
  });

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  @override
  void initState() {
    super.initState();
      print('🔹 channel: ${widget.channel} | type: ${widget.channel.runtimeType}');
  print('🔹 token: ${widget.token} | type: ${widget.token.runtimeType}');
  print('🔹 uid: ${widget.uid} | type: ${widget.uid.runtimeType}');
    context.read<VideoCallBloc>().add(
          VideoCallEvents.started(
            channel: widget.channel,
            token: widget.token,
            uid: widget.uid,
          ),
        );
  }

  @override
  void dispose() {
    context.read<VideoCallBloc>().add(const VideoCallEvents.ended());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Call')),
      body: BlocBuilder<VideoCallBloc, VideoCallStates>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text("Initializing...")),
            connected: (engine, localUserJoined, remoteUid) => Stack(
              children: [
                Center(
                  child: remoteUid != null
                      ? AgoraVideoView(
                          controller: VideoViewController.remote(
                            rtcEngine: engine!,
                            canvas: VideoCanvas(uid: remoteUid),
                            connection: RtcConnection(channelId: widget.channel),
                          ),
                        )
                      : const Text('Waiting for remote user to join'),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: SizedBox(
                    width: 120,
                    height: 160,
                    child: (localUserJoined ?? false)
                        ? AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: engine!,
                              canvas: VideoCanvas(uid: 0),
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
            callEnded: () => const Center(child: Text("Call Ended")),
          );
        },
      ),
      bottomSheet: Container(
        height: 60,
        color: AppColor.primaryColor,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<VideoCallBloc>().add(const VideoCallEvents.ended());
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('End Call'),
          ),
        ),
      ),
    );
  }
}
