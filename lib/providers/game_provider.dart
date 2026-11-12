import 'dart:async';
import 'dart:math';

import 'package:material_ui/material_ui.dart';

//konsa item ha road per
class GameItem {
  GameItem({
    required this.lane,
    required this.isCoin,
    required this.height,
    required this.y,
  });

  final double height;
  final bool isCoin;
  final int lane;
  double y;
}

//value for run game
class GameProvider extends ChangeNotifier {
  final List<GameItem> items = [];
  double roadOffset = 0;

  int _coins = 0;
  int _currentDistance = 0;
  int _currentLane = 1;
  double _exactMeters = 0;
  int _highScore = 3000;
  bool _isGameOver = false;
  bool _isPaused = false;
  final Random _rng = Random();
  double _spawnGap = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int get highScore => _highScore;

  int get currentDistance => _currentDistance;

  int get coins => _coins;

  int get currentLane => _currentLane;

  bool get isPaused => _isPaused;

  bool get isGameOver => _isGameOver;

  //game start karni ka function
  void startGame({
    required double areaHeight,
    required double carHeight,
    required double coinSize,
    required double playerTop,
    required double playerBottom,
    required VoidCallback onGameOver,
  }) {
    //agar game reset hoo gia ha to timer ruk gia
    gameReset();
    _timer?.cancel();
    _spawnGap = areaHeight * 0.3;

    final watch = Stopwatch()..start();
    var lastMs = 0;

    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      final nowMs = watch.elapsedMilliseconds;
      final dt = ((nowMs - lastMs) / 1000.0).clamp(0.0, 0.05);
      lastMs = nowMs;

      if (_isPaused || _isGameOver) return;

      final speedFactor = (0.45 + (_currentDistance ~/ 500) * 0.05).clamp(
        0.45,
        1.2,
      );
      final step = areaHeight * speedFactor * dt;

      roadOffset = (roadOffset + step) % 80;

      //distance calculate karna
      _exactMeters += speedFactor * dt * 40;
      if (_exactMeters.floor() > _currentDistance) {
        _currentDistance = _exactMeters.floor();
        if (_currentDistance > _highScore) _highScore = _currentDistance;
      }

      for (final it in items) {
        it.y += step;
      }
      items.removeWhere((it) => it.y > areaHeight);

      //ya hes lia ka ketna part guzur chuka ha
      _spawnGap -= step;
      if (_spawnGap <= 0) {
        _spawnPattern(carHeight, coinSize);
        _spawnGap = areaHeight * (0.45 + _rng.nextDouble() * 0.25);
      }

      for (final it in items.toList()) {
        if (it.lane != _currentLane) continue;
        final overlap =
            it.y + it.height > playerTop + 10 && it.y < playerBottom - 10;
        if (!overlap) continue;

        if (it.isCoin) {
          items.remove(it);
          _coins++;
        } else {
          _isGameOver = true;
          _timer?.cancel();
          notifyListeners();
          onGameOver();
          return;
        }
      }

      notifyListeners();
    });
  }

  void stopGame() => _timer?.cancel();

  //left lane per jani kii lia
  void moveLeft() {
    if (_currentLane > 0 && !_isPaused && !_isGameOver) {
      _currentLane--;
      notifyListeners();
    }
  }

  //for right lane
  void moveRight() {
    if (_currentLane < 2 && !_isPaused && !_isGameOver) {
      _currentLane++;
      notifyListeners();
    }
  }

  //calculate coins
  void coinsCalculate() {
    _coins++;
    notifyListeners();
  }

  void addDistance(int meter) {
    _currentDistance += meter;
    if (_currentDistance > _highScore) _highScore = _currentDistance;
    notifyListeners();
  }

  //game ko rukna aur chalani kii lia
  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  //hab game reset hoo gia to sara kuch pher pahli jasa hoo gia
  void gameReset() {
    _currentDistance = 0;
    _exactMeters = 0;
    _coins = 0;
    _currentLane = 1;
    _isPaused = false;
    _isGameOver = false;
    roadOffset = 0;
    items.clear();
    notifyListeners();
  }

  void _spawnPattern(double carHeight, double coinSize) {
    final freeLane = _rng.nextInt(3);
    for (var lane = 0; lane < 3; lane++) {
      if (lane == freeLane) {
        if (_rng.nextDouble() < 0.6) {
          items.add(
            GameItem(lane: lane, isCoin: true, height: coinSize, y: -coinSize),
          );
        }
      } else if (_rng.nextDouble() < 0.55) {
        items.add(
          GameItem(lane: lane, isCoin: false, height: carHeight, y: -carHeight),
        );
      }
    }
  }
}
