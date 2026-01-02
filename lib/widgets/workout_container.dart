import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/widgets/text_styles.dart';

class WorkoutCard extends StatelessWidget {
  final String dateText;
  final String title;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.dateText,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFF1E1E20),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left accent bar
            Container(
              width: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFF2EC4FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),

            // Spacer between accent bar and content
            SizedBox(width: 12.w),

            // Text content with Expanded
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  spacing: 6.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [bold12Text(dateText), bold24Text(title)],
                ),
              ),
            ),

            // Arrow icon
            IconButton(
              icon: Icon(Icons.arrow_forward, size: 18.sp),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
