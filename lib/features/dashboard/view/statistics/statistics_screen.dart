import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/widgets.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedPeriodIndex = 0; // 0 = Все время, 1 = 30 дней, 2 = 7 дней

  final Map<DateTime, int> _toiletEntries = {
    DateTime(2026, 2, 1): 2,
    DateTime(2026, 2, 2): 1,
    DateTime(2026, 2, 3): 3,
    DateTime(2026, 2, 5): 1,
    DateTime(2026, 2, 7): 2,
    DateTime(2026, 2, 10): 1,
    DateTime(2026, 2, 12): 4,
    DateTime(2026, 2, 15): 2,
    DateTime(2026, 2, 18): 1,
    DateTime(2026, 2, 20): 3,
    DateTime(2026, 2, 22): 2,
    DateTime(2026, 2, 24): 1,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final stats = _calculateStatistics(_selectedPeriodIndex);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          Text(
            'Статистика',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Анализ посещений туалета',
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onSurfaceVariant,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 24.h),

          // Период
          PeriodSelector(
            selectedIndex: _selectedPeriodIndex,
            onPeriodSelected: (index) {
              setState(() {
                _selectedPeriodIndex = index;
              });
            },
          ),
          SizedBox(height: 24.h),

          // Основные карточки
          StatCard(
            icon: Icons.water_drop_outlined,
            title: 'Всего посещений',
            value: '${stats['total']}',
            subtitle: 'за выбранный период',
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: Icons.trending_up_rounded,
                  title: 'В день',
                  value: stats['avgPerDay']!.toStringAsFixed(1),
                  subtitle: 'в среднем',
                  isSmall: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: StatCard(
                  icon: Icons.calendar_month_rounded,
                  title: 'В месяц',
                  value: stats['avgPerMonth']!.toStringAsFixed(1),
                  subtitle: 'в среднем',
                  isSmall: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: Icons.arrow_upward_rounded,
                  title: 'Максимум',
                  value: '${stats['max']}',
                  subtitle: 'за один день',
                  isSmall: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: StatCard(
                  icon: Icons.arrow_downward_rounded,
                  title: 'Минимум',
                  value: '${stats['min']}',
                  subtitle: 'за один день',
                  isSmall: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Дни с посещениями
          StatCard(
            icon: Icons.event_available_rounded,
            title: 'Дней с посещениями',
            value: '${stats['daysWithEntries']}',
            subtitle: 'из ${stats['totalDays']} дней',
          ),
          SizedBox(height: 24.h),

          // Лучший и худший месяц
          if (stats['bestMonth'] != null) ...[
            Text(
              'Рекорды',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: RecordCard(
                    title: 'Больше всего',
                    value: '${stats['bestMonth']['count']}',
                    subtitle: stats['bestMonth']['month'],
                    isPositive: true,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: RecordCard(
                    title: 'Меньше всего',
                    value: '${stats['worstMonth']['count']}',
                    subtitle: stats['worstMonth']['month'],
                    isPositive: false,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Map<String, dynamic> _calculateStatistics(int periodIndex) {
    final now = DateTime.now();
    DateTime? startDate;

    // Определяем начальную дату в зависимости от выбранного периода
    if (periodIndex == 1) {
      // 30 дней
      startDate = now.subtract(const Duration(days: 29));
    } else if (periodIndex == 2) {
      // 7 дней
      startDate = now.subtract(const Duration(days: 6));
    }
    // periodIndex == 0 — все время (startDate остаётся null)

    // Фильтруем записи по выбранному периоду
    final filteredEntries = _toiletEntries.entries.where((entry) {
      if (startDate == null) return true;
      return !entry.key.isBefore(startDate) && !entry.key.isAfter(now);
    }).toList();

    if (filteredEntries.isEmpty) {
      return {
        'total': 0,
        'avgPerDay': 0.0,
        'avgPerMonth': 0.0,
        'max': 0,
        'min': 0,
        'daysWithEntries': 0,
        'totalDays': periodIndex == 1 ? 30 : (periodIndex == 2 ? 7 : 0),
        'bestMonth': null,
        'worstMonth': null,
      };
    }

    final total = filteredEntries.fold<int>(
      0,
      (sum, entry) => sum + entry.value,
    );
    final daysWithEntries = filteredEntries.length;

    final minDate = filteredEntries
        .map((e) => e.key)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    final maxDate = filteredEntries
        .map((e) => e.key)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    int totalDays;
    if (periodIndex == 1) {
      totalDays = 30;
    } else if (periodIndex == 2) {
      totalDays = 7;
    } else {
      totalDays = maxDate.difference(minDate).inDays + 1;
    }

    final values = filteredEntries.map((e) => e.value).toList();
    final max = values.reduce((a, b) => a > b ? a : b);
    final min = values.reduce((a, b) => a < b ? a : b);

    final avgPerDay = total / daysWithEntries;
    final avgPerMonth = avgPerDay * 30;

    final Map<String, int> monthlyStats = {};
    for (final entry in filteredEntries) {
      final monthKey =
          '${entry.key.year}-${entry.key.month.toString().padLeft(2, '0')}';
      monthlyStats[monthKey] = (monthlyStats[monthKey] ?? 0) + entry.value;
    }

    String? bestMonthKey;
    String? worstMonthKey;
    int? bestCount;
    int? worstCount;

    for (final entry in monthlyStats.entries) {
      if (bestCount == null || entry.value > bestCount) {
        bestCount = entry.value;
        bestMonthKey = entry.key;
      }
      if (worstCount == null || entry.value < worstCount) {
        worstCount = entry.value;
        worstMonthKey = entry.key;
      }
    }

    const months = [
      '',
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

    String formatMonth(String key) {
      final parts = key.split('-');
      final year = parts[0];
      final month = int.parse(parts[1]);
      return '${months[month]} $year';
    }

    return {
      'total': total,
      'avgPerDay': avgPerDay,
      'avgPerMonth': avgPerMonth,
      'max': max,
      'min': min,
      'daysWithEntries': daysWithEntries,
      'totalDays': totalDays,
      'bestMonth': {
        'count': bestCount ?? 0,
        'month': bestMonthKey != null ? formatMonth(bestMonthKey) : '',
      },
      'worstMonth': {
        'count': worstCount ?? 0,
        'month': worstMonthKey != null ? formatMonth(worstMonthKey) : '',
      },
    };
  }
}
