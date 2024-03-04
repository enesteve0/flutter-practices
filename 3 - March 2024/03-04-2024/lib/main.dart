import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatefulWidget {
  XylophoneApp({Key? key}) : super(key: key);

  @override
  XylophoneAppState createState() => XylophoneAppState();
}

class XylophoneAppState extends State<XylophoneApp> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _preloadSounds();
  }

  Future<void> _preloadSounds() async {
    for (int i = 1; i <= 7; i++) {
      await player.setAsset('assets/note$i.wav');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(color: Colors.red, soundNumber: 1),
              buildKey(color: Colors.orange, soundNumber: 2),
              buildKey(color: Colors.yellow, soundNumber: 3),
              buildKey(color: Colors.green, soundNumber: 4),
              buildKey(color: Colors.teal, soundNumber: 5),
              buildKey(color: Colors.blue, soundNumber: 6),
              buildKey(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKey({required Color color, required int soundNumber}) {
    return XylophoneKey(
      color: color,
      soundNumber: soundNumber,
      player: player,
    );
  }
}

class XylophoneKey extends StatelessWidget {
  final Color color;
  final int soundNumber;
  final AudioPlayer player;

  const XylophoneKey({
    Key? key,
    required this.color,
    required this.soundNumber,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: color),
        onPressed: () {
          playSound(soundNumber);
        },
        child: Container(),
      ),
    );
  }

  void playSound(int soundNumber) async {
    try {
      await player.setAsset('assets/note$soundNumber.wav');
      player.play();
    } catch (e) {
      // print("Error loading audio: $e");
      // Replace with a logging framework
    }
  }
}