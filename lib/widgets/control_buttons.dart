import 'package:flutter/material.dart';
import 'circular_button.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onReset;
  final bool hasTime;

  const ControlButtons({
    Key? key,
    required this.isRunning,
    required this.onStart,
    required this.onStop,
    required this.onReset,
    required this.hasTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!isRunning && !hasTime)
            const SizedBox(width: 70)
          else
            CircularButton(
              onPressed: onReset,
              icon: Icons.refresh,
              color: const Color(0xFF455A64),
              size: 70,
            ),
          CircularButton(
            onPressed: isRunning ? onStop : onStart,
            icon: isRunning ? Icons.pause : Icons.play_arrow,
            gradient: isRunning
                ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFF6B6B),
                const Color(0xFFFF8E53),
              ],
            )
                : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF4CAF50),
                const Color(0xFF66BB6A),
              ],
            ),
            isPrimary: true,
            size: 90,
          ),
          const SizedBox(width: 70),
        ],
      ),
    );
  }
}