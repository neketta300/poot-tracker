import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayCell extends StatelessWidget {
  final DateTime day;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isToday;
  final int entryCount;
  final VoidCallback onTap;

  const DayCell({
    super.key,
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.isToday,
    required this.entryCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : isToday
              ? colorScheme.primary.withAlpha(10)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected || isToday
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: _getDayTextColor(colorScheme),
                fontFamily: 'Nunito',
              ),
            ),
            if (entryCount > 0 && isCurrentMonth) ...[
              SizedBox(height: 4.h),
              EntryDots(count: entryCount),
            ],
          ],
        ),
      ),
    );
  }

  Color _getDayTextColor(ColorScheme colorScheme) {
    if (isSelected) return Colors.white;
    if (!isCurrentMonth) return Colors.grey.shade400;
    if (isToday) return colorScheme.primary;
    return colorScheme.onSurface;
  }
}

class EntryDots extends StatelessWidget {
  final int count;

  const EntryDots({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count > 3 ? 3 : count,
        (index) => Container(
          width: 4.w,
          height: 4.h,
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            color: [Colors.blue, Colors.brown, Colors.teal][index % 3],
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
