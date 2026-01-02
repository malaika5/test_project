import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/widgets/text_styles.dart';

import '../models/workout.dart';
import '../widgets/plan_week_widget.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

    final List<List<DateTime>> weekSets = [];

    for (int start = 1; start <= daysInMonth; start += 7) {
      final end = (start + 6 <= daysInMonth) ? start + 6 : daysInMonth;

      weekSets.add(
        List.generate(
          end - start + 1,
          (index) => DateTime(now.year, now.month, start + index),
        ),
      );
    }

    return SafeArea(
      child: Column(
        spacing: 20.h,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bold24Text("Training Calender", fontWeight: FontWeight.w400),
                bold18Text("Save"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: weekSets.length,
              itemBuilder: (context, index) {
                final weekDates = weekSets[index];

                final presentDays = weekDates.length > 2 ? 2 : 1;

                return PlanWeekContainer(
                  weekNumber: index + 1,
                  weekDates: weekDates,
                  presentDays: presentDays,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void moveWorkoutToDate(WidgetRef ref, WorkoutModel workout, DateTime newDate) {
  final workouts = ref.read(workoutsProvider.notifier).state;

  final index = workouts.indexWhere((w) => w.id == workout.id);
  if (index != -1) {
    final updatedWorkout = workout.copyWith(
      dateTime: DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        workout.dateTime.hour,
        workout.dateTime.minute,
      ),
    );

    final updatedWorkouts = [...workouts];
    updatedWorkouts[index] = updatedWorkout;

    ref.read(workoutsProvider.notifier).state = updatedWorkouts;
  }
}

final workoutsProvider = StateProvider<List<WorkoutModel>>(
  (ref) => [
    WorkoutModel(
      id: '3',
      title: 'Arms Workout',
      workout: 'Arm Blaster',
      duration: '25m - 30m',
      dateTime: DateTime(2026, 1, 1),
      svgAsset: 'assets/svgs/arm.svg',
      color: Color(0xff20B76F),
    ),
    WorkoutModel(
      id: '4',
      title: 'Leg Workout',
      workout: 'Leg Day Blitz',
      duration: '25m - 30m',
      dateTime: DateTime(2026, 1, 5),
      svgAsset: 'assets/svgs/leg.svg',
      color: Color(0xff4855DF),
    ),
  ],
);
