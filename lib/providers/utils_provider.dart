import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsProvider with ChangeNotifier {
  bool _isSounsPlaying = true;
  bool _isMusicTurnedOn = true;
  bool _isQuizMusicPlaying = false;

  UtilsProvider() {
    _loadFromPrefs();
  }

  bool get isSounsPlaying => _isSounsPlaying;
  bool get isMusicTurnedOn => _isMusicTurnedOn;
  bool get isQuizMusicPlaying => _isQuizMusicPlaying;

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final storedSound = prefs.getBool("isSoundPlaying");
    if (storedSound != null) {
      _isSounsPlaying = storedSound;
      notifyListeners();
    }
    final storedMusic = prefs.getBool("isMusicTurnedOn");
    if (storedMusic != null) {
      _isMusicTurnedOn = storedMusic;
      notifyListeners();
    }
  }

  void switchIsSounsPlaying() {
    if (_isSounsPlaying) {
      _isSounsPlaying = false;
    } else {
      _isSounsPlaying = true;
    }
    _saveSoundToPrefs();
    notifyListeners();
  }

  void musicPlayingTrue() {
    _isMusicTurnedOn = true;
    _saveMusicToPrefs();
    notifyListeners();
  }

  void musicPlayingFalse() {
    _isMusicTurnedOn = false;
    _saveMusicToPrefs();
    notifyListeners();
  }

  void quizMusicPlayingTrue() {
    _isQuizMusicPlaying = true;
  }

  void quizMusicPlayingFalse() {
    _isQuizMusicPlaying = false;
  }

  Future<void> _saveSoundToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSoundPlaying', _isSounsPlaying);
  }

  Future<void> _saveMusicToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMusicTurnedOn', _isMusicTurnedOn);
  }

  final player = AudioPlayer();
  final quizMusic = AudioPlayer();

  Future<void> playMusic() async {
    await player.setVolume(0.8);
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource(
      'audio/music1.mp3',
    ));
  }

  Future<void> stopMusic() async {
    player.stop();
  }

  Future<void> playQuizMusic() async {
    await quizMusic.setVolume(0.8);
    await quizMusic.setReleaseMode(ReleaseMode.loop);
    await quizMusic.play(AssetSource(
      'audio/quiz1.mp3',
    ));
  }

  Future<void> stopQuizMusic() async {
    quizMusic.stop();
  }
}
