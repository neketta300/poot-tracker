import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntryBottomSheet extends StatelessWidget {
  final DateTime selectedDay;
  final int currentCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onSave;

  const EntryBottomSheet({
    super.key,
    required this.selectedDay,
    required this.currentCount,
    required this.onIncrement,
    required this.onDecrement,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Заголовок
          Text(
            'Отметка количества посещения',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _formatDate(selectedDay),
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onSurfaceVariant,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 32.h),

          // Счётчик
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCounterButton(
                icon: Icons.remove,
                onTap: currentCount > 0 ? onDecrement : null,
                colorScheme: colorScheme,
              ),
              SizedBox(width: 48.w),
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$currentCount',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 48.w),
              _buildCounterButton(
                icon: Icons.add,
                onTap: onIncrement,
                colorScheme: colorScheme,
              ),
            ],
          ),
          SizedBox(height: 32.h),

          // Кнопка сохранения
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Сохранить',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback? onTap,
    required ColorScheme colorScheme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: onTap != null
              ? colorScheme.primary
              : colorScheme.onSurface.withAlpha(50),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28.sp,
          color: onTap != null
              ? colorScheme.onPrimary
              : colorScheme.onSurface.withAlpha(100),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
