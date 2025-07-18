import 'dart:ui';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talky/features/video_call/domain/agora_repository.dart';

class AgoraServiceImpl implements AgoraRepository {
  final String appId;
  RtcEngine? _engine;
  int? _remoteUid;
  bool _localUserJoined = false;

  AgoraServiceImpl({required this.appId});

  @override
  RtcEngine? get engine => _engine;
  @override
  int? get remoteUid => _remoteUid;
  @override
  bool get localUserJoined => _localUserJoined;

  @override
  Future<void> initAgora(
    String channel,
    String token,
    int uid,
    VoidCallback onJoined,
    Function(int uid) onRemoteJoined,
    VoidCallback onRemoteLeft,
  ) async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    _engine!.registerEventHandler(RtcEngineEventHandler(
 onJoinChannelSuccess: (_, __) {
  print("✅ Local user joined");
  _localUserJoined = true;
  onJoined();
},
onUserJoined: (_, remoteUid, __) {
  print("👤 Remote user joined: $remoteUid");
  _remoteUid = remoteUid;
  onRemoteJoined(remoteUid);
},
onUserOffline: (_, uid, __) {
  print("❌ Remote user left: $uid");
  _remoteUid = null;
  onRemoteLeft();
},

    ));

    await _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine!.enableVideo();
    await _engine!.startPreview();
    await _engine!.joinChannel(
      token: token,
      channelId: channel,
      uid: uid,
      options: const ChannelMediaOptions(),
    );

    print(token);
    print("//////////////////////////////////");
    print(channel);
    print(uid);
  }

  @override
  Future<void> disposeAgora() async {
    await _engine?.leaveChannel();
    await _engine?.release();
    _engine = null;
    _remoteUid = null;
    _localUserJoined = false;
  }
}
