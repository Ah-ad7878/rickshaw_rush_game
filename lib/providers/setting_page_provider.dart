import 'package:just_audio/just_audio.dart';
import 'package:material_ui/material_ui.dart';

class SettingPageProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _initialize = false;
  bool _isSound = true;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  bool get sound => _isSound;

  Future<void> playBackgroundMusics() async {
    if (!_initialize) {
      await _audioPlayer.setAsset('assets/musics/game.mp3');
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.setVolume(0.2);
      _initialize = true;
    }

    if (_isSound && !_audioPlayer.playing) {
      _audioPlayer.play();
    }
  }

  Future<void> toggleSound() async {
    _isSound = !_isSound;
    if (_isSound) {
      if (!_initialize) {
        await playBackgroundMusics();
      } else {
        _audioPlayer.play();
      }
    } else {
      await _audioPlayer.pause();
    }
    notifyListeners();
  }
}
