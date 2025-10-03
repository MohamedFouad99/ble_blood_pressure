// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleReading extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color baseColor;

  const CircleReading({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    required this.baseColor,
  });

  /// Returns a color based on the value and max.
  ///
  /// The color changes as follows:
  ///
  /// - Green for values less than 50% of max.
  /// - Orange for values less than 80% of max.
  /// - Red for values greater than or equal to 80% of max.
  Color _getColor(int v, int max) {
    final percent = v / max;
    if (percent < 0.5) return Colors.green;
    if (percent < 0.8) return Colors.orange;
    return Colors.red; // عالي
  }

  @override
  /// Builds a column with a Tween animation of a CircularProgressIndicator and a Text widget.
  ///
  /// The CircularProgressIndicator's value and color changes based on the provided value and max.
  /// The Text widget's value and color changes based on the provided value and max.
  ///
  /// The animation's duration is set to 1 second and its curve is set to Curves.easeOutCubic.
  ///
  Widget build(BuildContext context) {
    final percent = (value / max).clamp(0.0, 1.0);
    final targetColor = _getColor(value, max);

    return Column(
      children: [
        SizedBox(
          height: 80.w,
          width: 80.w,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: percent),
            duration: const Duration(seconds: 1),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              return TweenAnimationBuilder<Color?>(
                tween: ColorTween(begin: Colors.green, end: targetColor),
                duration: const Duration(seconds: 1),
                builder: (context, animatedColor, child) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: animatedValue,
                        strokeWidth: 8,
                        color: animatedColor,
                        backgroundColor: animatedColor?.withOpacity(0.2),
                      ),
                      Center(
                        child: TweenAnimationBuilder<int>(
                          tween: IntTween(begin: 0, end: value),
                          duration: const Duration(seconds: 1),
                          builder: (context, animatedNumber, child) {
                            return Text(
                              '$animatedNumber',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: animatedColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(color: targetColor)),
      ],
    );
  }
}
