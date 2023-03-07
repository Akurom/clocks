import 'package:clocks/utils/utils.dart';
import 'package:clocks/views/widgets/analog_clock/analog_clock_widget.dart';
import 'package:clocks/views/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _animation;
  late bool _isMenuOpen;

  @override
  void initState() {
    _isMenuOpen = false;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (!_isMenuOpen)
      _controller.forward();
    else
      _controller.reverse();

    _isMenuOpen = !_isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    double maxSlide = screenWidth(context) * 3 / 4;

    return SafeArea(
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            double slide = _controller.value;
            double scale = 1 - _controller.value * 0.3;
            return Stack(
              children: [
                Transform.translate(
                  offset: Offset(maxSlide * (_controller.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(pi / 2 * (1 - _controller.value)),
                    alignment: Alignment.centerRight,
                    child: Menu(callback: _toggle), // todo pass callback to reverse animation on click
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * _controller.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-pi / 2 * _controller.value),
                    /*..translate(slide)
                    ..scale(scale),*/
                    alignment: Alignment.centerLeft,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Icon(
                                Icons.menu,
                                size: 42,
                              ),
                              onTap: () {
                                _toggle();
                              },
                            ),
                          ),
                          const Clock(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
