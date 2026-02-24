import 'package:flutter/material.dart';
import 'calendar_types.dart';
import 'calendar_header.dart';
import 'year_grid_view.dart';
import 'month_grid_view.dart';
import 'calendar_grid.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  int _focusedYear = DateTime.now().year;
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDay;
  CalendarViewType _viewLevel = CalendarViewType.day;

  final Map<DateTime, int> _toiletEntries = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarHeader(
          focusedYear: _focusedYear,
          focusedMonth: _focusedMonth,
          viewLevel: _viewLevel,
          onNavigate: _handleNavigate,
          onViewTypeChanged: _handleViewTypeChanged,
        ),
        Expanded(child: _buildCalendarContent()),
      ],
    );
  }

  void _handleNavigate(int delta) {
    setState(() {
      switch (_viewLevel) {
        case CalendarViewType.year:
          _focusedYear += delta;
          break;
        case CalendarViewType.month:
          // При навигации в режиме "Месяц" меняем месяц (и год при необходимости)
          _focusedMonth = DateTime(
            _focusedMonth.year,
            _focusedMonth.month + delta,
          );
          _focusedYear = _focusedMonth.year;
          break;
        case CalendarViewType.day:
          _focusedMonth = DateTime(
            _focusedMonth.year,
            _focusedMonth.month + delta,
          );
          break;
      }
    });
  }

  void _handleViewTypeChanged(CalendarViewType level) {
    setState(() {
      if (level == CalendarViewType.month) {
        // При переключении на режим "Месяц" синхронизируем год с текущим месяцем
        _focusedYear = _focusedMonth.year;
      }
      _viewLevel = level;
    });
  }

  Widget _buildCalendarContent() {
    switch (_viewLevel) {
      case CalendarViewType.year:
        return YearGridView(
          focusedYear: _focusedYear,
          onYearSelected: (year) {
            setState(() {
              _focusedYear = year;
              _focusedMonth = DateTime(year, 1, 1);
              _viewLevel = CalendarViewType.month;
            });
          },
        );
      case CalendarViewType.month:
        return MonthGridView(
          focusedYear: _focusedYear,
          focusedMonth: _focusedMonth,
          onMonthSelected: (month) {
            setState(() {
              _focusedMonth = month;
              _viewLevel = CalendarViewType.day;
            });
          },
        );
      case CalendarViewType.day:
        return DayGridView(
          focusedMonth: _focusedMonth,
          selectedDay: _selectedDay,
          toiletEntries: _toiletEntries,
          onDaySelected: (day) => setState(() => _selectedDay = day),
        );
    }
  }
}
