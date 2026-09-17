
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:alllab/main.dart';

void main() {
  testWidgets('Нажатие на лайк показывает Snackbar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MovieApp());

    // Находим первую кнопку лайка
    final likeButton = find.byKey(const Key('like_0'));

    expect(likeButton, findsOneWidget);

    // Нажимаем на лайк
    await tester.tap(likeButton);
    await tester.pump();

    // Проверяем Snackbar
    expect(find.byType(SnackBar), findsOneWidget);
    expect(
      find.text('Фильм добавлен в избранное'),
      findsOneWidget,
    );
  });

  testWidgets('Нажатие на карточку открывает детали',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MovieApp());

    // Нажимаем на первую карточку
    await tester.tap(find.byType(Card).first);
    await tester.pump();

    // Проверяем окно с подробной информацией
    expect(find.byType(AlertDialog), findsOneWidget);

    expect(
      find.text('Интерстеллар'),
      findsWidgets,
    );

    expect(
      find.text('Описание'),
      findsOneWidget,
    );

    expect(
      find.text('Закрыть'),
      findsOneWidget,
    );
  });
}

