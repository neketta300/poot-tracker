enum CalendarViewType { year, month, day }

typedef DaySelectedCallback = void Function(DateTime day);
typedef MonthSelectedCallback = void Function(DateTime month);
typedef YearSelectedCallback = void Function(int year);
typedef NavigateCallback = void Function(int delta);
typedef ViewTypeChangedCallback = void Function(CalendarViewType level);
