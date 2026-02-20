import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CheckmarkPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  CheckmarkPainter({required this.color, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap
          .round // скруглённые концы
      ..strokeJoin = StrokeJoin.round; // скруглённые углы

    final path = Path();
    // Начальная точка (левый нижний угол галочки)
    path.moveTo(size.width * 0.15, size.height * 0.5);
    // Средняя точка (пик галочки)
    path.lineTo(size.width * 0.45, size.height * 0.8);
    // Конечная точка (правый верхний угол)
    path.lineTo(size.width * 0.9, size.height * 0.25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CheckmarkPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}

// Вспомогательный класс для хранения диапазонов выделения
class _HighlightRange {
  final int start;
  final int end;

  _HighlightRange({required this.start, required this.end});
}

// Функция для создания TextSpan с несколькими выделениями
TextSpan buildMultipleHighlightedText({
  required String fullText,
  required List<String> highlightTexts,
  required Color highlightColor,
  required TextStyle baseStyle,
}) {
  List<TextSpan> children = [];

  // Создаем карту всех выделений с их позициями
  List<_HighlightRange> ranges = [];

  for (String highlightText in highlightTexts) {
    final index = fullText.toLowerCase().indexOf(highlightText.toLowerCase());

    if (index != -1) {
      ranges.add(
        _HighlightRange(start: index, end: index + highlightText.length),
      );
    }
  }

  // Сортируем по позиции начала
  ranges.sort((a, b) => a.start.compareTo(b.start));

  int lastEnd = 0;

  for (var range in ranges) {
    // Добавляем обычный текст до выделения
    if (range.start > lastEnd) {
      children.add(
        TextSpan(
          text: fullText.substring(lastEnd, range.start),
          style: baseStyle,
        ),
      );
    }

    // Добавляем выделенный текст
    children.add(
      TextSpan(
        text: fullText.substring(range.start, range.end),
        style: baseStyle.copyWith(color: highlightColor),
      ),
    );

    lastEnd = range.end;
  }

  // Добавляем оставшийся текст
  if (lastEnd < fullText.length) {
    children.add(TextSpan(text: fullText.substring(lastEnd), style: baseStyle));
  }

  return TextSpan(children: children);
}

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool isOption1Selected = false;
  bool isOption2Selected = false;
  bool isOption3Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 36.h),
            Center(
              child: SvgPicture.asset(
                'assets/images/vectors/consent/consent_im.svg',
              ),
            ),
            SizedBox(height: 26.h),
            Text(
              'Конфиденциальность',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'превыше всего',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 26.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    children: [
                      RadioConsentButton(
                        isSelected: isOption1Selected,
                        onTap: () => setState(
                          () => isOption1Selected = !isOption1Selected,
                        ),
                        text:
                            'Я соглашаюсь с обработкой персональных данных о здоровье для целей функционирования приложения.\nПодробнее см. в Политике конфиденциальности.',
                        highlightTexts: ['Политике конфиденциальности'],
                      ),
                      RadioConsentButton(
                        isSelected: isOption2Selected,
                        onTap: () => setState(
                          () => isOption2Selected = !isOption2Selected,
                        ),
                        text:
                            'Я соглашаюсь с Политикой конфиденциальности и Условиями использования.',
                        highlightTexts: [
                          'Политикой конфиденциальности',
                          'Условиями использования',
                        ],
                      ),
                      RadioConsentButton(
                        isSelected: isOption3Selected,
                        onTap: () => setState(
                          () => isOption3Selected = !isOption3Selected,
                        ),
                        text:
                            'Я разрешаю Poot отслеживать мою активность в приложении. Я понимаю, что AppsFlyer, Firebase и их интегрированные партнеры могут получать информацию о моей возрастной группе, статусе подписки, запуске приложения и технических идентификаторах в соответствии с Политикой конфиденциальности. Это поможет Poot улучшить рекламные кампании.',
                        highlightTexts: ['Политикой конфиденциальности'],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SecondaryButton(text: 'Принять всё'),
            SizedBox(height: 5.h),
            PrimaryButton(text: 'Далее'),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  const PrimaryButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 170.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(150),
          borderRadius: BorderRadius.circular(50.w),
        ),
        child: Center(
          child: Text(
            'Далее',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const SecondaryButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class RadioConsentButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final String text;
  final List<String>? highlightTexts;

  const RadioConsentButton({
    super.key,
    required this.isSelected,
    required this.text,
    this.onTap,
    this.highlightTexts,
  });

  @override
  Widget build(BuildContext context) {
    // Базовый стиль текста
    final baseStyle = TextStyle(
      fontSize: 16.sp,
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontFamily: 'Nunito',
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade400,
                  width: 2.w,
                ),
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Center(
                        child: CustomPaint(
                          size: Size(9.w, 9.w),
                          painter: CheckmarkPainter(
                            color: Colors.white,
                            strokeWidth: 1.5.w, // 👈 регулируйте толщину здесь
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: highlightTexts != null && highlightTexts!.isNotEmpty
                  ? RichText(
                      text: buildMultipleHighlightedText(
                        fullText: text,
                        highlightTexts: highlightTexts!,
                        highlightColor: Theme.of(context).colorScheme.primary,
                        baseStyle: baseStyle,
                      ),
                    )
                  : Text(text, style: baseStyle),
            ),
          ],
        ),
      ),
    );
  }
}
