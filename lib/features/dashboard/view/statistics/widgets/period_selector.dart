import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'period_button.dart';

class PeriodSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onPeriodSelected;

  const PeriodSelector({
    super.key,
    required this.selectedIndex,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(10),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.primary.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Период',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: PeriodButton(
                  text: 'Все время',
                  isSelected: selectedIndex == 0,
                  onTap: () => onPeriodSelected(0),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: PeriodButton(
                  text: '30 дней',
                  isSelected: selectedIndex == 1,
                  onTap: () => onPeriodSelected(1),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: PeriodButton(
                  text: '7 дней',
                  isSelected: selectedIndex == 2,
                  onTap: () => onPeriodSelected(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
