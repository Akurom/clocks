import 'package:clocks/utils/utils.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 60000));
    /*_animation = Tween<double>(
      begin: 0.0,
      end: 360.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));*/
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: screenWidth(context) * 3 / 4,
        height: screenWidth(context) * 3 / 4,
        child: Stack(
          children: [
            // 5mn marks
            for (int i = 0; i < 12; i++) ...[
              RotationTransition(
                turns: AlwaysStoppedAnimation(360 / 12 * i / 360),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 0,
                      height: 20,
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                    ),
                  ),
                ),
            ],

            // needles
            RotationTransition(
              turns: _animation, //AlwaysStoppedAnimation(360 / 12 * 0 / 360),
              child: Center(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 0,
                    height: screenWidth(context) * 3 / 8,
                    decoration: BoxDecoration(border: Border.all(width: 0.25, color: Colors.blue)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
