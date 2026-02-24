import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_types.dart';
import 'day_cell.dart';
import 'weekday_headers.dart';

class DayGridView extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime? selectedDay;
  final Map<DateTime, int> toiletEntries;
  final DaySelectedCallback onDaySelected;

  const DayGridView({
    super.key,
    required this.focusedMonth,
    required this.selectedDay,
    required this.toiletEntries,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final days = CalendarUtils.generateDaysGrid(focusedMonth);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const WeekdayHeaders(),
          SizedBox(height: 8.h),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 4,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                return DayCell(
                  day: day,
                  isCurrentMonth: day.month == focusedMonth.month,
                  isSelected: CalendarUtils.isSameDay(day, selectedDay),
                  isToday: CalendarUtils.isToday(day),
                  entryCount: toiletEntries[day] ?? 0,
                  onTap: () => onDaySelected(day),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarUtils {
  static List<DateTime> generateDaysGrid(DateTime month) {
    final List<DateTime> days = [];
    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 0);

    final firstWeekday = startDate.weekday - 1;
    final prevMonth = DateTime(startDate.year, startDate.month - 1, 0);
    for (int i = firstWeekday - 1; i >= 0; i--) {
      days.add(DateTime(prevMonth.year, prevMonth.month, prevMonth.day - i));
    }

    DateTime current = startDate;
    while (!current.isAfter(endDate)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    final remaining = 42 - days.length;
    for (int i = 1; i <= remaining; i++) {
      days.add(DateTime(endDate.year, endDate.month + 1, i));
    }

    return days;
  }

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isToday(DateTime day) {
    final now = DateTime.now();
    return day.year == now.year &&
        day.month == now.month &&
        day.day == now.day;
  }
}
