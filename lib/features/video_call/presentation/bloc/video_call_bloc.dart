import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_call_events.dart';
import 'video_call_states.dart';
import '../../domain/agora_repository.dart';

class VideoCallBloc extends Bloc<VideoCallEvents, VideoCallStates> {
  final AgoraRepository agora;

  VideoCallBloc(this.agora) : super(const Initial()) {
    on<Started>(_onStart);
    on<RemoteJoined>(_onRemoteJoined);
    on<RemoteLeft>(_onRemoteLeft);
    on<Ended>(_onEnded);
  }

  Future<void> _onStart(Started event, Emitter<VideoCallStates> emit) async {

    await agora.initAgora(
      event.channel,
      event.token,
      event.uid,
      () {
        emit(Connected(
          engine: agora.engine,
          localUserJoined: agora.localUserJoined,
          remoteUid: agora.remoteUid,
        ));
      },
      (uid) => add(VideoCallEvents.remoteJoined(uid)),
      () => add(const VideoCallEvents.remoteLeft()),
    );
  }

  void _onRemoteJoined(RemoteJoined event, Emitter<VideoCallStates> emit) {
    emit(Connected(
      engine: agora.engine,
      localUserJoined: agora.localUserJoined,
      remoteUid: event.uid,
    ));
  }

  void _onRemoteLeft(RemoteLeft event, Emitter<VideoCallStates> emit) {
    emit(Connected(
      engine: agora.engine,
      localUserJoined: agora.localUserJoined,
      remoteUid: null,
    ));
  }

  Future<void> _onEnded(Ended event, Emitter<VideoCallStates> emit) async {
    await agora.disposeAgora();
    emit(const CallEnded());
  }
}
