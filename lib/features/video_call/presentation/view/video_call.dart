import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class VideoCall extends StatefulWidget {
  final String token;
  final int rid; // remote user ID
  final int uid; // local user ID

  const VideoCall({
    super.key,
    required this.rid,
    required this.uid, required this.token,
  });

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  static const String appId = "ebb96245b4d1498c9668fd48865f9024";
  static const String role = "publisher";
  static const String serverUrl = "https://test-api-4u0w.onrender.com/rtc";

  late RtcEngine _engine;
  bool _localUserJoined = false;
  int? _remoteUid;
  String? _channelName;

  @override
  void initState() {
    super.initState();
    _initVideoCall();
  }

  String _generateChannelName(int uid1, int uid2) {
    final sorted = [uid1, uid2]..sort();
    return 'call_${sorted[0]}_${sorted[1]}';
  }

  Future<String> _fetchTokenFromServer(String channel, int uid) async {
    try {
      final dio = Dio();
      final response = await dio.get('$serverUrl/$channel/$role/$uid');
      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      } else {
        throw Exception("Token missing in server response");
      }
    } catch (e) {
      throw Exception("Failed to fetch token: $e");
    }
  }

  Future<void> _initVideoCall() async {
    await _requestPermissions();

    _channelName = _generateChannelName(widget.uid, widget.rid);
    _engine = createAgoraRtcEngine();

    await _engine.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          setState(() => _localUserJoined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left");
          setState(() => _remoteUid = null);
        },
        onError: (ErrorCodeType code, String msg) {
          debugPrint("Agora error: $code - $msg");
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    try {
      final token = await _fetchTokenFromServer(_channelName!, widget.uid);

      await _engine.joinChannel(
        token: token,
        channelId: _channelName!,
        uid: widget.uid,
        options: const ChannelMediaOptions(),
      );
    } catch (e) {
      debugPrint("Join channel error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error joining call: $e")),
        );
      }
    }
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera] != PermissionStatus.granted ||
        statuses[Permission.microphone] != PermissionStatus.granted) {
      throw Exception("Camera and microphone permissions are required.");
    }
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agora One-to-One Call")),
      body: Stack(
        children: [
          if (_localUserJoined)
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          if (_remoteUid != null)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: _engine,
                    canvas: VideoCanvas(uid: _remoteUid),
                    connection: RtcConnection(channelId: _channelName!),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
