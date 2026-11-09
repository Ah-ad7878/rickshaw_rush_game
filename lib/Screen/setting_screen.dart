import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:rickshaw_rush/providers/setting_page_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final soundProvdier = context.watch<SettingPageProvider>();
    return Scaffold(
      backgroundColor: Color(0xFF0F766E),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 42.h,
                      width: 42.w,
                      decoration: BoxDecoration(
                        color: Color(0xFFFACC15),
                        shape: BoxShape.circle,
                      ),

                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 28.sp,
                      ),
                    ),
                  ),

                  SizedBox(width: 9.w),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Color(0xFFFACC15),
                      fontSize: 32.sp,
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Color(0xFF134E4A),
                  borderRadius: BorderRadius.circular(16.r),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Musics and effects',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),

                        Text(
                          'Sound',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: .bold,
                          ),
                        ),
                      ],
                    ),

                    Switch(
                      value: soundProvdier.sound,
                      onChanged: (value) {
                        context.read<SettingPageProvider>().toggleSound();
                      },

                      activeThumbColor: const Color(0xFF1E293B),
                      activeTrackColor: const Color(0xFFFACC15),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFF1E293B),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
