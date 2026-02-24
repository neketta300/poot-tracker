import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_types.dart';

class CalendarHeader extends StatefulWidget {
  final int focusedYear;
  final DateTime focusedMonth;
  final CalendarViewType viewLevel;
  final NavigateCallback onNavigate;
  final ViewTypeChangedCallback onViewTypeChanged;

  const CalendarHeader({
    super.key,
    required this.focusedYear,
    required this.focusedMonth,
    required this.viewLevel,
    required this.onNavigate,
    required this.onViewTypeChanged,
  });

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavButton(
                icon: Icons.chevron_left,
                onTap: () {
                  setState(() {
                    widget.onNavigate(-1);
                  });
                },
              ),
              Text(
                _getTitle(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              NavButton(
                icon: Icons.chevron_right,
                onTap: () {
                  setState(() {
                    widget.onNavigate(1);
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ViewTypeButton(
                text: 'Год',
                isActive: widget.viewLevel == CalendarViewType.year,
                onTap: () => widget.onViewTypeChanged(CalendarViewType.year),
              ),
              SizedBox(width: 8.w),
              ViewTypeButton(
                text: 'Месяц',
                isActive: widget.viewLevel == CalendarViewType.month,
                onTap: () => widget.onViewTypeChanged(CalendarViewType.month),
              ),
              SizedBox(width: 8.w),
              ViewTypeButton(
                text: 'День',
                isActive: widget.viewLevel == CalendarViewType.day,
                onTap: () => widget.onViewTypeChanged(CalendarViewType.day),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (widget.viewLevel) {
      case CalendarViewType.year:
        return '${widget.focusedYear}';
      case CalendarViewType.month:
        return _getShortMonthName(widget.focusedMonth);
      case CalendarViewType.day:
        return _getMonthName(widget.focusedMonth);
    }
  }

  String _getMonthName(DateTime month) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return '${months[month.month - 1]} ${month.year}';
  }

  String _getShortMonthName(DateTime month) {
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
    return '${months[month.month - 1]} ${month.year}';
  }
}

class NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const NavButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 28.sp),
      color: colorScheme.onSurface,
    );
  }
}

class ViewTypeButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const ViewTypeButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
