import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/widgets/text_styles.dart';

import '../widgets/custom_painter.dart';

final moodAngleProvider = StateProvider<double>((ref) {
  return -pi / 2; // Calm at top
});

final moodProvider = StateProvider<String>((ref) {
  return "Calm";
});

class MoodScreen extends ConsumerWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mood = ref.watch(moodProvider);

    return Stack(
      children: [
        Image.asset(
          'assets/images/mood_bg.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bold40Text(
                    "Mood",
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.left,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        bold18Text(
                          "Start your day",
                          fontWeight: FontWeight.w400,
                        ),
                        bold18Text(
                          "How are you feeling at the Moment?",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Center(child: moodRing(ref, 280.w)),
                  SizedBox(height: 24.h),
                  Center(
                    child: bold24Text(
                      mood,
                      textAlign: TextAlign.center,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 164.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.5.h),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),

                      onPressed: () {},
                      child: bold16Text(
                        "Continue",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String moodFromAngle(double angle) {
    final normalized = (angle + 2 * pi) % (2 * pi);

    if (normalized < pi / 2) return "Content";
    if (normalized < pi) return "Peaceful";
    if (normalized < 3 * pi / 2) return "Happy";
    return "Calm";
  }

  Widget moodRing(WidgetRef ref, double size) {
    final angle = ref.watch(moodAngleProvider);
    final mood = ref.watch(moodProvider);

    return GestureDetector(
      onPanUpdate: (details) {
        final center = Offset(size / 2, size / 2);
        final pos = details.localPosition;

        final newAngle = atan2(pos.dy - center.dy, pos.dx - center.dx);

        ref.read(moodAngleProvider.notifier).state = newAngle;
        ref.read(moodProvider.notifier).state = moodFromAngle(newAngle);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🌈 Gradient Ring
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  startAngle: 0,
                  endAngle: 2 * pi,
                  colors: [
                    Color(0xffC9BBEF), // Peaceful
                    Color(0xffF28DB3), // Happy
                    Color(0xffF99955), // Content
                    Color(0xff6EB9AD), // Calm
                  ],
                ),
              ),
            ),
            CustomPaint(
              size: Size(size, size),
              painter: RingSegmentPainter(
                segments: 15, // 👈 adjust count
                lineColor: Colors.white24,
                strokeWidth: 2.w,
              ),
            ),
            // ⚫ Inner Circle
            Container(
              width: size * 0.75,
              height: size * 0.75,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 110.w,
              height: 110.h,
              decoration: BoxDecoration(
                color: color(mood),
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.all(12.r),
              child: SvgPicture.asset(
                'assets/svgs/${moodEmoji(mood)}',
                height: mood == 'Peaceful' ? 50.h : null,
                width: mood == 'Peaceful' ? 55.w : null,
                fit: BoxFit.contain, // or BoxFit.cover, etc.
              ),
            ),

            Transform.translate(
              offset: Offset(
                cos(angle) * (size / 2 - 15),
                sin(angle) * (size / 2 - 15),
              ),
              child: Container(
                width: 57.w,
                height: 57.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String moodEmoji(String mood) {
    switch (mood) {
      case "Happy":
        return "happy.svg";
      case "Calm":
        return "calm.svg";
      case "Peaceful":
        return "peace.svg";
      default:
        return "content.svg";
    }
  }

  Color color(String mood) {
    switch (mood) {
      case "Happy":
        return Color(0xffF6C186);
      case "Calm":
        return Color(0xffF0CFC4);
      case "Peaceful":
        return Color(0xffF6C186);
      default:
        return Color(0xffF8D458);
    }
  }
}
