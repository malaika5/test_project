import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBarContainer extends ConsumerWidget {
  final Widget child;
  const NavBarContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF000000),
        border: Border(top: BorderSide(color: Color(0xff282A39))),
      ),

      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
      child: child,
    );
  }
}
