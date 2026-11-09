import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rickshaw_rush/custom_painter/rickshaw_painter.dart';
import 'package:rickshaw_rush/navigator/route_name_class.dart';
import 'package:rickshaw_rush/providers/setting_page_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingPageProvider>().playBackgroundMusics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F766E),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Rickshaw',
                  style: TextStyle(
                    color: const Color(0xFFFACC15),
                    fontSize: 46.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),

                Text(
                  'Rush',
                  style: TextStyle(
                    color: const Color(0xFFFACC15),
                    fontSize: 46.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),

                SizedBox(height: 13.h),
                Text(
                  'Lahore ki sadak par daud',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                SizedBox(height: 40.h),
                SizedBox(
                  width: 115.w,
                  height: 130.h,
                  child: CustomPaint(painter: RickshawPainter()),
                ),

                SizedBox(height: 32.h),
                _buildMenuButton(
                  text: 'Play',
                  bgColor: const Color(0xFFFACC15),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNameClass.gameScreenRouteName,
                    );
                  },
                ),

                SizedBox(height: 16.h),
                _buildMenuButton(
                  text: 'Settings',
                  bgColor: const Color(0xFF134E4A),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNameClass.settingScreenRouteName,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildMenuButton({
  required String text,
  required Color bgColor,
  required Color textColor,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    height: 54.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
