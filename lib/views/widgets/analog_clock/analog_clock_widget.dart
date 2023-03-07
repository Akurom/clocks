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
  late AnimationController _ctrlSeconds;
  late AnimationController _ctrlMinutesHours;
  late final Animation<double> _animation;

  DateTime _now = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 60000));
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
                _ctrlSeconds = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
                _ctrlMinutesHours = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
                void _tick() {
                  _ctrlSeconds.forward();
                }

                _tick();

                return Stack(
                  children: [
                    // seconds
                    RotationTransition(
                      turns: Tween<double>(
                        begin: 360 / 60 * (clock.seconds - 1) / 360,
                        end: 360 / 60 * clock.seconds / 360,
                      ).animate(CurvedAnimation(parent: _ctrlSeconds, curve: Curves.elasticOut)),
                      child: Center(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: screenWidth(context) * 1 / 16)),
                              Container(
                                width: 0,
                                height: screenWidth(context) * 5 / 16,
                                decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.blue)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // minutes
                    RotationTransition(
                      turns: Tween<double>(
                        begin: 360 / 60 * (clock.minutes) / 360,
                        end: 360 / 60 * (clock.minutes + 1) / 360,
                      ).animate(CurvedAnimation(parent: _ctrlMinutesHours, curve: Curves.elasticOut)),
                      child: Center(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: screenWidth(context) * 2 / 16)),
                              Container(
                                width: 0,
                                height: screenWidth(context) * 4 / 16,
                                decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // hours
                    RotationTransition(
                      turns: Tween<double>(
                        begin: 360 / 12 * (clock.hours) / 360,
                        end: 360 / 12 * (clock.hours + 1) / 360,
                      ).animate(CurvedAnimation(parent: _ctrlMinutesHours, curve: Curves.elasticOut)),
                      child: Center(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: screenWidth(context) * 3 / 16)),
                              Container(
                                width: 0,
                                height: screenWidth(context) * 3 / 16,
                                decoration: BoxDecoration(border: Border.all(width: 3, color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
