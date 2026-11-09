import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rickshaw_rush/navigator/route_name_class.dart';
import 'package:rickshaw_rush/providers/game_provider.dart';
import 'package:rickshaw_rush/providers/home_screen_provider.dart';
import 'package:rickshaw_rush/providers/setting_page_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => SettingPageProvider()),
      ],
      child: const NameBar(),
    ),
  );
}

class NameBar extends StatelessWidget {
  const NameBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Rickshaw Rush',
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNameClass.homeScreenRouteName,
          onGenerateRoute: RouteNameClass.generateRoute,
        );
      },
    );
  }
}
