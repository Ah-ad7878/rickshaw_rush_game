import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:rickshaw_rush/custom_painter/rickshaw_painter.dart';
import 'package:rickshaw_rush/custom_painter/road_painter.dart';
import 'package:rickshaw_rush/navigator/route_name_class.dart';
import 'package:rickshaw_rush/providers/game_provider.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late final GameProvider _game;
  bool _started = false;

  @override
  void dispose() {
    _game.stopGame();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _game = context.read<GameProvider>();
  }

  double get _carW => 70.w;

  double get _carH => 100.h;

  double get _coinSize => 30.w;

  double get _rickW => 65.w;

  double get _rickH => 75.h;

  double get _rickBottom => 60.h;

  double _leftFor(int lane, double areaWidth, double itemWidth) {
    final laneWidth = areaWidth / 3;
    return (lane * laneWidth) + (laneWidth - itemWidth) / 2;
  }

  void _startOnce(double areaHeight) {
    if (_started) return;
    _started = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _game.startGame(
        areaHeight: areaHeight,
        carHeight: _carH,
        coinSize: _coinSize,
        playerTop: areaHeight - _rickBottom - _rickH,
        playerBottom: areaHeight - _rickBottom,
        onGameOver: () {
          if (!mounted) return;
          Navigator.pushReplacementNamed(
            context,
            RouteNameClass.gameOverScreenRouteName,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final g = context.watch<GameProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF334155),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              color: const Color(0xFF1E293B),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${g.currentDistance} m',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${g.coins} coins',
                    style: TextStyle(
                      color: const Color(0xFFFACC15),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: g.togglePause,
                    child: Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFACC15),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        g.isPaused ? Icons.play_arrow : Icons.pause,
                        color: Colors.black,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, c) {
                  final areaW = c.maxWidth;
                  _startOnce(c.maxHeight);

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragEnd: (d) {
                      final v = d.primaryVelocity ?? 0;
                      if (v < 0) _game.moveLeft();
                      if (v > 0) _game.moveRight();
                    },
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: RoadPainter(g.roadOffset),
                          ),
                        ),

                        for (final it in g.items)
                          Positioned(
                            top: it.y,
                            left: _leftFor(
                              it.lane,
                              areaW,
                              it.isCoin ? _coinSize : _carW,
                            ),
                            child: it.isCoin
                                ? Container(
                                    width: _coinSize,
                                    height: _coinSize,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFACC15),
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : Container(
                                    width: _carW,
                                    height: _carH,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDC2626),
                                      borderRadius: BorderRadius.circular(14.r),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.w,
                                      ),
                                    ),
                                  ),
                          ),

                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOut,
                          bottom: _rickBottom,
                          left: _leftFor(g.currentLane, areaW, _rickW),
                          child: SizedBox(
                            width: _rickW,
                            height: _rickH,
                            child: CustomPaint(painter: RickshawPainter()),
                          ),
                        ),

                        if (g.isPaused)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black54,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'PAUSED',
                                      style: TextStyle(
                                        color: const Color(0xFFFACC15),
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    ElevatedButton(
                                      onPressed: g.togglePause,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFFACC15,
                                        ),
                                        foregroundColor: Colors.black,
                                      ),
                                      child: const Text('Resume'),
                                    ),
                                    SizedBox(height: 8.h),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        RouteNameClass
                                            .settingScreenTwoRoutename,
                                      ),
                                      child: const Text('Setting page'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
