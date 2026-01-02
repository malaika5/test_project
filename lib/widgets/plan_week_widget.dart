import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'plan_data_tile.dart';
import 'text_styles.dart';

class PlanWeekContainer extends StatelessWidget {
  final int weekNumber;
  final List<DateTime> weekDates;
  final int presentDays;
  final int index;

  const PlanWeekContainer({
    super.key,
    required this.weekNumber,
    required this.weekDates,
    required this.presentDays,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = weekDates.first;
    final endDate = weekDates.last;

    String formatWeekRange(DateTime start, DateTime end) {
      if (start.month == end.month) {
        return "${start.day}-${end.day} ${DateFormat('MMMM').format(start)}";
      } else {
        return "${start.day} ${DateFormat('MMM').format(start)} - ${end.day} ${DateFormat('MMMM').format(end)}"; // 28 Dec - 3 Jan
      }
    }

    String weekRange = formatWeekRange(startDate, endDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Week Header
        Container(
          decoration: BoxDecoration(color: const Color(0xFF1E1E20)),
          padding: EdgeInsets.all(8.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bold18Text("Week $weekNumber"),
                  bold16Text(weekRange, fontWeight: FontWeight.w400),
                ],
              ),
              bold16Text(
                "Total: 60 Mins",
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: weekDates.map((date) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 4.h),
                    child: PlanDateTile(date: date),
                  ),

                  Divider(height: 1.h, color: Color(0xff282A39)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
