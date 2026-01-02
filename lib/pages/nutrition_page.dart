// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:test_project/widgets/calender_bottom_sheet.dart'
    show CalendarBottomSheet;
import 'package:test_project/widgets/detail_container.dart';
import 'package:test_project/widgets/text_styles.dart';

import '../widgets/weather_function.dart';
import '../widgets/workout_container.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final displayMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
});

class NutritionPage extends ConsumerStatefulWidget {
  const NutritionPage({super.key});

  @override
  ConsumerState<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends ConsumerState<NutritionPage> {
  final ScrollController _scrollController = ScrollController();
  late List<GlobalKey> _dateKeys;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _scrollToSelectedDate() {
    final selectedDate = ref.read(selectedDateProvider);
    final index = selectedDate.day - 1;

    if (index < 0 || index >= _dateKeys.length) return;

    final contextKey = _dateKeys[index].currentContext;
    if (contextKey == null) return;

    final box = contextKey.findRenderObject() as RenderBox;
    final position = box.localToGlobal(
      Offset.zero,
      ancestor: context.findRenderObject(),
    );

    final offset = _scrollController.offset + position.dx - 25.w;

    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int weekOfMonth(DateTime date) => ((date.day - 1) ~/ 7) + 1;

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    // final today = DateTime.now();

    final daysInMonth = DateUtils.getDaysInMonth(
      selectedDate.year,
      selectedDate.month,
    );

    final totalWeeks = ((daysInMonth - 1) ~/ 7) + 1;

    final monthDates = List.generate(
      daysInMonth,
      (i) => DateTime(selectedDate.year, selectedDate.month, i + 1),
    );

    _dateKeys = List.generate(monthDates.length, (_) => GlobalKey());

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------- HEADER ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/ring.svg',
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.contain, // or BoxFit.cover, etc.
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => const CalendarBottomSheet(),
                      );

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToSelectedDate();
                      });
                    },
                    child: Row(
                      spacing: 4.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/week.svg',
                          width: 18.w,
                          height: 18.h,
                          fit: BoxFit.contain, // or BoxFit.cover, etc.
                          color: Colors.white,
                        ),
                        bold14Text(
                          'Week ${weekOfMonth(selectedDate)}/$totalWeeks',
                        ),

                        Icon(Icons.arrow_drop_down, size: 20.sp),
                      ],
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 8.h),
              bold16Text(
                'Today, ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
              ),

              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: monthDates.asMap().entries.map((entry) {
                    final index = entry.key;
                    final date = entry.value;

                    final isSelected = DateUtils.isSameDay(date, selectedDate);

                    return GestureDetector(
                      key: _dateKeys[index],
                      onTap: () {
                        ref.read(selectedDateProvider.notifier).state = date;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToSelectedDate();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Column(
                          spacing: 3.h,
                          children: [
                            bold12Text(shortDayName(date)),

                            Container(
                              height: 44.h,
                              width: 44.w,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Color(0xff20B76F).withOpacity(0.20)
                                    : Color(0xff18181C),
                                border: Border.all(
                                  width: 2.r,
                                  color: isSelected
                                      ? Color(0xff20B76F)
                                      : Color(0xff18181C),
                                ),
                              ),
                              child: Center(child: bold14Text('${date.day}')),
                            ),

                            Container(
                              width: 8.r,
                              height: 8.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Color(0xff20B76F)
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bold24Text('Workouts', fontWeight: FontWeight.w600),

                  Row(
                    children: [
                      Icon(getDayNightIcon(), size: 30.sp),
                      FutureBuilder<double?>(
                        future: getTemperatureCelsius(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return bold14Text('Loading...'); // Loading state
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            final temp = snapshot.data ?? 0;
                            return bold24Text(
                              "${temp.toStringAsFixed(1)} °",
                              fontWeight: FontWeight.w600,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              WorkoutCard(
                dateText: 'December 22 - 25m - 30m',
                title: 'Upper Body',
                onTap: () {
                  // Navigate or handle tap
                },
              ),
              bold24Text('My Insights'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.w,
                children: [
                  Expanded(
                    child: DetailContainer(
                      child: Padding(
                        padding: EdgeInsets.all(7.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                bold40Text('550', fontWeight: FontWeight.w600),
                                bold18Text(
                                  'Calories',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                            bold14Text(
                              '1950 Remaining ',
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  bold14Text(
                                    '0',
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.left, // align left
                                  ),
                                  bold14Text(
                                    '2500 ',
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.right, // align left
                                  ),
                                ],
                              ),
                            ),
                            LinearPercentIndicator(
                              percent: 550 / 2500,
                              lineHeight: 8.h,

                              barRadius: Radius.circular(10.r),
                              backgroundColor: const Color(0xFF2A2D31),
                              linearGradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7BBDE2),
                                  Color(0xFF69C0B1),
                                  Color(0xff60C198),
                                ],
                              ),
                              animation: true,
                              animationDuration: 800,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DetailContainer(
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Column(
                          spacing: 4.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                bold40Text('75', fontWeight: FontWeight.w600),
                                bold18Text('Kg', textAlign: TextAlign.end),
                              ],
                            ),
                            Row(
                              spacing: 4.w,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff154124),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(4.r),
                                  child: Icon(
                                    Icons.north_east,
                                    size: 15.sp,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                bold14Text('+1.6 Kg', textAlign: TextAlign.end),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            bold18Text('Weight'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff121212),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Row: Percentage & vertical progress bar
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Percentage
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bold40Text('0%', color: Color(0xff4DA6FF)),
                                  SizedBox(height: 20.h),
                                  bold18Text('Hydration'),

                                  bold12Text(
                                    'Log Now',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // center all containers
                                spacing: 2.h,
                                children: [
                                  Row(
                                    spacing: 4.w,
                                    children: [
                                      bold10Text(
                                        "2L",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      waterContainer(),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.w),
                                    child: Column(
                                      spacing: 8.h,
                                      children: [
                                        lightContainer(),
                                        lightContainer(),
                                        lightContainer(),
                                        lightContainer(),
                                        waterContainer(),
                                        lightContainer(),
                                        lightContainer(),
                                        lightContainer(),
                                        lightContainer(),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    spacing: 4.w,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          bold10Text(
                                            "OL",
                                            fontWeight: FontWeight.w600,
                                          ),
                                          waterContainer(),
                                          SizedBox(
                                            width: 50.w,
                                            child: Divider(
                                              color: Color(0xff363638),
                                              height: 1.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                      bold16Text(
                                        "0ml",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 13.h,
                          horizontal: 12.w,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0XFF1B3D45),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.r),
                            bottomRight: Radius.circular(8.r),
                          ),
                        ),
                        child: bold12Text(
                          '500 ml added to water log',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String shortDayName(DateTime date) {
    final day = DateFormat('EEE').format(date); // Mon, Tue, Wed...

    switch (day) {
      case 'Mon':
        return 'M';
      case 'Wed':
        return 'W';
      case 'Fri':
        return 'F';
      case 'Tue':
        return 'TU';
      case 'Thu':
        return 'TH';
      case 'Sat':
        return 'SA';
      case 'Sun':
        return 'SU';
      default:
        return day;
    }
  }

  IconData getDayNightIcon() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 18) {
      return Icons.wb_sunny; // ☀️ Day
    } else {
      return Icons.nightlight_round; // 🌙 Night
    }
  }

  Widget lightContainer() {
    return Container(
      height: 2.h,
      width: 8.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Color(0xff48A4E5).withOpacity(0.30),
      ),
    );
  }

  Widget waterContainer() {
    return Container(
      height: 5.h,
      width: 14.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Color(0xff4DA6FF),
      ),
    );
  }
}
