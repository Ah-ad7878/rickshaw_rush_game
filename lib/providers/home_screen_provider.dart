import 'package:material_ui/material_ui.dart';

class HomeScreenProvider extends ChangeNotifier {
  int _hightScore = 2480;

  int get hightScore => _hightScore;

  void updateScore(int newScore) {
    if (newScore > _hightScore) {
      _hightScore = newScore;
      notifyListeners();
    }
  }
}
