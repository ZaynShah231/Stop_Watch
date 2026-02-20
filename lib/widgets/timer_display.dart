import 'package:flutter/material.dart';
import '../utils/time_formatter.dart';

class TimerDisplay extends StatelessWidget {
  final int milliseconds;
  final bool isRunning;
  final AnimationController pulseController;

  const TimerDisplay({
    Key? key,
    required this.milliseconds,
    required this.isRunning,
    required this.pulseController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
            border: Border.all(
              color: isRunning
                  ? Color.lerp(
                const Color(0xFF2196F3),
                const Color(0xFF64B5F6),
                pulseController.value,
              )!
                  : Colors.white.withOpacity(0.1),
              width: 2,
            ),
            boxShadow: isRunning
                ? [
              BoxShadow(
                color: const Color(0xFF2196F3).withOpacity(
                  0.3 + (pulseController.value * 0.2),
                ),
                blurRadius: 30 + (pulseController.value * 20),
                spreadRadius: 5,
              ),
            ]
                : [],
          ),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  TimeFormatter.format(milliseconds),
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontFamily: 'monospace',
                    letterSpacing: 3,
                    shadows: isRunning
                        ? [
                      Shadow(
                        color: const Color(0xFF2196F3).withOpacity(0.5),
                        blurRadius: 20,
                      ),
                    ]
                        : [],
                  ),
                ),
              ),
              if (milliseconds > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _getSubtimeText(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.5),
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _getSubtimeText() {
    int totalSeconds = (milliseconds / 1000).truncate();
    if (totalSeconds < 60) {
      return '$totalSeconds seconds';
    } else {
      int minutes = (totalSeconds / 60).truncate();
      int seconds = totalSeconds % 60;
      return '$minutes min $seconds sec';
    }
  }
}