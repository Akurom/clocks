import 'dart:async';

import 'package:clocks/models/clock_model.dart';
import 'package:clocks/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  DateTime _now = DateTime.now();
  late Timer _timer;

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
    _timer?.cancel();
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
            // bg digits current session
            Center(
              child: Opacity(
                opacity: 0.2,
                child: Consumer<ClockModel>(
                  builder: (_, clock, __) {
                    return Text(
                      formatTimer(clock.hours, clock.minutes),
                      style: Theme.of(context).textTheme.displayLarge,
                    );
                  },
                ),
              ),
            ),

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
            Consumer<ClockModel>(
              builder: (_, clock, __) {
                AnimationController _ctrl =
                    AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
                void _tick() {
                  _ctrl.forward();
                }

                _tick();
                print(clock.seconds);

                return RotationTransition(
                  turns: Tween<double>(
                    begin: 360 / 60 * (clock.seconds - 1) / 360,
                    end: 360 / 60 * clock.seconds / 360,
                  ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut)),
                  child: Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 0,
                        height: screenWidth(context) * 3 / 8,
                        decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.blue)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
