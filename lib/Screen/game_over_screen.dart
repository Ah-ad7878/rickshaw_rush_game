import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:rickshaw_rush/navigator/route_name_class.dart';
import 'package:rickshaw_rush/providers/game_provider.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    return Scaffold(
      backgroundColor: Color(0xFF1E293B),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Game Over',
                  style: TextStyle(
                    color: Color(0xFFFACC15),
                    fontSize: 40.sp,
                    fontWeight: .bold,
                  ),
                ),

                SizedBox(height: 20.h),
                Text(
                  'Distance',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),

                SizedBox(height: 20.h),
                Text(
                  '${gameProvider.currentDistance} m',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64.sp,
                    fontWeight: .bold,
                  ),
                ),

                SizedBox(height: 20.h),
                Text(
                  'coins: ${gameProvider.coins}',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),

                SizedBox(height: 28.h),
                _buildGameOverButton(
                  text: 'Restart',
                  bgColor: const Color(0xFFFACC15),
                  textColor: Colors.black,
                  onPressed: () {
                    context.read<GameProvider>().gameReset();
                    Navigator.pushNamed(
                      context,
                      RouteNameClass.gameScreenRouteName,
                    );
                  },
                ),
                SizedBox(height: 14.h),
                _buildGameOverButton(
                  text: 'Home',
                  bgColor: const Color(0xFF334155),
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<GameProvider>().gameReset();
                    Navigator.popUntil(context, (route) => route.isFirst);
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

Widget _buildGameOverButton({
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
        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
