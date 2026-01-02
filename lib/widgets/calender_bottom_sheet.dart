import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_project/widgets/text_styles.dart';

import '../pages/nutrition_page.dart';

class CalendarBottomSheet extends ConsumerWidget {
  const CalendarBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayMonth = ref.watch(displayMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final today = DateTime.now();

    final daysInMonth = DateUtils.getDaysInMonth(
      displayMonth.year,
      displayMonth.month,
    );

    final firstOfMonth = DateTime(displayMonth.year, displayMonth.month, 1);

    /// Monday-based offset (0–6)
    final startOffset = (firstOfMonth.weekday + 6) % 7;

    final List<Widget> dayWidgets = [];

    /// Empty leading cells
    for (int i = 0; i < startOffset; i++) {
      dayWidgets.add(const SizedBox());
    }

    /// Actual days
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(displayMonth.year, displayMonth.month, day);

      final isSelected = DateUtils.isSameDay(date, selectedDate);
      final isToday = DateUtils.isSameDay(date, today);

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            ref.read(selectedDateProvider.notifier).state = date;
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  // ignore: deprecated_member_use
                  ? Color(0xff20B76F).withOpacity(0.19)
                  : Colors.transparent,
              border: isSelected || isToday
                  ? Border.all(color: Color(0xff20B76F), width: 1.5)
                  : null,
            ),
            child: bold14Text('$day'),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        spacing: 8.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  ref.read(displayMonthProvider.notifier).state = DateTime(
                    displayMonth.year,
                    displayMonth.month - 1,
                  );
                },
              ),
              Expanded(
                child: Center(
                  child: bold16Text(
                    DateFormat('MMMM yyyy').format(displayMonth),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  ref.read(displayMonthProvider.notifier).state = DateTime(
                    displayMonth.year,
                    displayMonth.month + 1,
                  );
                },
              ),
            ],
          ),

          Row(
            children: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((d) => Expanded(child: Center(child: bold12Text(d))))
                .toList(),
          ),

          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 4.h,
            crossAxisSpacing: 4.w,
            children: dayWidgets,
          ),
        ],
      ),
    );
  }
}
