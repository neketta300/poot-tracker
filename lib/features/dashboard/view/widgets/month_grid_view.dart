import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_types.dart';

class MonthGridView extends StatelessWidget {
  final int focusedYear;
  final DateTime focusedMonth;
  final MonthSelectedCallback onMonthSelected;

  const MonthGridView({
    super.key,
    required this.focusedYear,
    required this.focusedMonth,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = DateTime(focusedYear, index + 1, 1);
        final isSelected =
            focusedMonth.month == index + 1 && focusedMonth.year == focusedYear;

        return MonthCell(
          month: month,
          isSelected: isSelected,
          onTap: () => onMonthSelected(month),
        );
      },
    );
  }
}

class MonthCell extends StatelessWidget {
  final DateTime month;
  final bool isSelected;
  final VoidCallback onTap;

  const MonthCell({
    super.key,
    required this.month,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const months = [
      'Янв',
      'Фев',
      'Мар',
      'Апр',
      'Май',
      'Июн',
      'Июл',
      'Авг',
      'Сен',
      'Окт',
      'Ноя',
      'Дек',
    ];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withAlpha(10)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            months[month.month - 1],
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
