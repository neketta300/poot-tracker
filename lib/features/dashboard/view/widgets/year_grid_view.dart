import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_types.dart';

class YearGridView extends StatelessWidget {
  final int focusedYear;
  final YearSelectedCallback onYearSelected;

  const YearGridView({
    super.key,
    required this.focusedYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final year = focusedYear - 6 + index;
        final isSelected = year == focusedYear;

        return YearCell(
          year: year,
          isSelected: isSelected,
          onTap: () => onYearSelected(year),
        );
      },
    );
  }
}

class YearCell extends StatelessWidget {
  final int year;
  final bool isSelected;
  final VoidCallback onTap;

  const YearCell({
    super.key,
    required this.year,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            '$year',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
