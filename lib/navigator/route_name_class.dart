import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rickshaw_rush/Screen/game_over_screen.dart';
import 'package:rickshaw_rush/Screen/game_screen.dart';
import 'package:rickshaw_rush/Screen/home_screen.dart';
import 'package:rickshaw_rush/Screen/setting_page_two.dart';
import 'package:rickshaw_rush/Screen/setting_screen.dart';

class RouteNameClass {
  static const String gameOverScreenRouteName = '/gameOver';
  static const String gameScreenRouteName = '/gameScreen';
  static const String homeScreenRouteName = '/';
  static const String settingScreenRouteName = '/setting';
  static const String settingScreenTwoRoutename = '/settingTwoScreen';

  static Route<dynamic> generateRoute(RouteSettings setting) {
    if (setting.name == homeScreenRouteName) {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    } else if (setting.name == gameScreenRouteName) {
      return MaterialPageRoute(builder: (context) => PlayScreen());
    } else if (setting.name == settingScreenRouteName) {
      return MaterialPageRoute(builder: (context) => SettingScreen());
    } else if (setting.name == settingScreenTwoRoutename) {
      return MaterialPageRoute(builder: (context) => SettingPageTwo());
    } else if (setting.name == gameOverScreenRouteName) {
      return MaterialPageRoute(builder: (context) => GameOverScreen());
    } else {
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(
                'Page Not Found',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: .bold,
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
