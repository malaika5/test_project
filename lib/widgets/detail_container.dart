import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailContainer extends ConsumerWidget {
  final Widget child;
  const DetailContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E20), // Light mode background
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(color: Color(0xFF18181C), width: 1.r),
      ),

      child: child,
    );
  }
}
