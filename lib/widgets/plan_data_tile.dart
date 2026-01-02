// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_project/widgets/text_styles.dart';

import '../models/workout.dart';
import '../pages/plan_page.dart';
import 'week_schedule_container.dart';

class PlanDateTile extends ConsumerWidget {
  final DateTime date;
  const PlanDateTile({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutsProvider);
    debugPrint('Rebuilding PlanDateTile for date: ${workouts.first.dateTime}');
    // Find workouts for this date

    bool isSameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    final workoutsForDate = workouts
        .where((w) => isSameDay(w.dateTime, date))
        .toList();

    final hasWorkout = workoutsForDate.isNotEmpty;
    final textColor = hasWorkout == false ? Color(0xFF5D607C) : null;
    DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 6.h),
      child: Row(
        spacing: 10.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bold14Text(
                DateFormat('EEEE').format(date).substring(0, 3),
                color: textColor,
              ),
              bold18Text(
                date.day.toString(),
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ],
          ),
          Expanded(
            child: DragTarget<WorkoutModel>(
              onWillAccept: (_) => true,
              onAccept: (workout) {
                final allWorkouts = [...ref.read(workoutsProvider)];
                final index = allWorkouts.indexWhere((w) => w.id == workout.id);
                if (index == -1) return;

                allWorkouts[index] = workout.copyWith(
                  dateTime: normalize(date),
                );

                ref.read(workoutsProvider.notifier).state = allWorkouts;
              },
              builder: (context, candidateData, rejectedData) {
                if (workoutsForDate.isEmpty) {
                  return SizedBox(
                    height: 75.h,
                  ); // same as one workout container
                }

                return Column(
                  children: workoutsForDate.map((workout) {
                    return Draggable<WorkoutModel>(
                      data: workout,
                      feedback: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: WeekScheduleContainer(workoutModel: workout),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.3,
                        child: WeekScheduleContainer(workoutModel: workout),
                      ),
                      child: WeekScheduleContainer(workoutModel: workout),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
