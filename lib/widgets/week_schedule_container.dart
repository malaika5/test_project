import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/widgets/text_styles.dart';

import '../models/workout.dart';

class WeekScheduleContainer extends StatelessWidget {
  final WorkoutModel workoutModel;

  WeekScheduleContainer({super.key, required this.workoutModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF1E1E20),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 8.w,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    bottomLeft: Radius.circular(14.r),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    spacing: 4.w,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SvgPicture.asset(
                          'assets/svgs/dots.svg',

                          // ignore: deprecated_member_use
                        ),
                      ),
                      Column(
                        spacing: 4.h,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: workoutModel.color.withOpacity(
                                0.17,
                              ), // random color
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  workoutModel.svgAsset,
                                  // ignore: deprecated_member_use
                                  color: workoutModel.color,
                                ),
                                SizedBox(width: 4.w),
                                bold10Text(
                                  workoutModel.workout,
                                  color:
                                      workoutModel.color, // same random color
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),

                          bold14Text(
                            workoutModel.title,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bold16Text(workoutModel.duration, fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ),
    );
  }

  final List<Color> workoutColors = [
    const Color(0xff20B76F), // green
    const Color(0xff4855DF), // blue
  ];

  Color itemColorRandom() {
    final random = Random();
    return workoutColors[random.nextInt(workoutColors.length)];
  }
}
