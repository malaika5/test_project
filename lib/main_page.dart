import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_project/pages/mood_page.dart';
import 'package:test_project/pages/nutrition_page.dart';
import 'package:test_project/widgets/text_styles.dart';

import 'pages/plan_page.dart';
import 'pages/profile_page.dart';
import 'widgets/bottom_navbar.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  final List<String> tabs = ["Nutrition", "Plan", "Mood", "Profile"];

  final List<Widget> tabViews = const [
    NutritionPage(),
    PlanPage(),
    MoodScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      backgroundColor: Color(0xFF000000),
      bottomNavigationBar: NavBarContainer(
        child: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = currentIndex == index;

              final List<String> icons = [
                'assets/svgs/nutrition.svg',
                'assets/svgs/plan.svg',
                'assets/svgs/emotion.svg',
                'assets/svgs/profile.svg',
              ];

              return Expanded(
                child: InkWell(
                  onTap: () {
                    ref.read(bottomNavIndexProvider.notifier).state = index;
                  },
                  child: Column(
                    spacing: 4.h,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        icons[index],
                        width: 22.w,
                        height: 22.h,
                        fit: BoxFit.contain, // or BoxFit.cover, etc.
                        // ignore: deprecated_member_use
                        color: isSelected ? Colors.white : Colors.grey,
                      ),

                      bold14Text(
                        tabs[index],
                        textAlign: TextAlign.center,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,

                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      body: tabViews[currentIndex],
    );
  }
}
