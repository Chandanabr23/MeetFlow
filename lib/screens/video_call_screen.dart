import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallScreen extends StatefulWidget {
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final localRenderer = RTCVideoRenderer();
  final remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  bool micOn = true;
  bool camOn = true;

  @override
  void initState() {
    super.initState();
    initRenderers();
    startCall();
  }

  Future<void> initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
  }

  Future<bool> _requestPermissions() async {
    final cam = await Permission.camera.request();
    final mic = await Permission.microphone.request();
    return cam.isGranted && mic.isGranted;
  }

  Future<void> startCall() async {
    final granted = await _requestPermissions();
    if (!granted) return;

    localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {'facingMode': 'user'}
    });
    localRenderer.srcObject = localStream;

    final config = {'iceServers': [{'urls': 'stun:stun.l.google.com:19302'}]};
    peerConnection = await createPeerConnection(config);

    localStream!.getTracks().forEach((track) {
      peerConnection!.addTrack(track, localStream!);
    });

    peerConnection!.onTrack = (event) {
      if (event.streams.isNotEmpty) remoteRenderer.srcObject = event.streams[0];
    };
  }

  void toggleMic() {
    micOn = !micOn;
    localStream?.getAudioTracks().forEach((track) => track.enabled = micOn);
    setState(() {});
  }

  void toggleCamera() {
    camOn = !camOn;
    localStream?.getVideoTracks().forEach((track) => track.enabled = camOn);
    setState(() {});
  }

  Future<void> shareScreen() async {
    try {
      final screenStream = await navigator.mediaDevices.getDisplayMedia({'video': true});
      final track = screenStream.getVideoTracks()[0];
      peerConnection?.addTrack(track, screenStream);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Screen share permission denied")),
      );
    }
  }

  @override
  void dispose() {
    localRenderer.dispose();
    remoteRenderer.dispose();
    peerConnection?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Call")),
      body: Stack(
        children: [
          Positioned.fill(child: RTCVideoView(remoteRenderer)),
          Positioned(
            top: 20, right: 20, width: 120, height: 160,
            child: RTCVideoView(localRenderer, mirror: true),
          ),
          Positioned(
            bottom: 30, left: 30, right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  child: Icon(micOn ? Icons.mic : Icons.mic_off),
                  onPressed: toggleMic,
                ),
                FloatingActionButton(
                  child: Icon(camOn ? Icons.videocam : Icons.videocam_off),
                  onPressed: toggleCamera,
                ),
                FloatingActionButton(
                  child: Icon(Icons.screen_share),
                  onPressed: shareScreen,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
