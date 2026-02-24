import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poot_tracker/features/dashboard/view/widgets/custom_calendar.dart';
import 'package:poot_tracker/features/dashboard/view/widgets/dashboard_bottom_nav.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Poot',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ),

      // Фон тоже из темы
      backgroundColor: colorScheme.surface,

      body: IndexedStack(
        index: _currentIndex,
        children: const [
          CustomCalendar(),
          // StatisticsView(),
        ],
      ),

      // FAB стилизуется из темы
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEntryDialog,
        // Можно оставить явные цвета или использовать theme
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: Text('Добавить', style: TextStyle(fontSize: 16.sp)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BottomNav стилизуется из темы
      bottomNavigationBar: DashboardBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  void _showAddEntryDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // ✅ Фон модалки из темы
      backgroundColor: colorScheme.surface,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Center(
          child: Text(
            'Форма добавления записи',
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant, // ✅ Вторичный текст
            ),
          ),
        ),
      ),
    );
  }
}
