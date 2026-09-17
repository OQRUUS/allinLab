
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alllab/main.dart';
import 'package:alllab/repositories/show_repository_impl.dart';

void main() {
  testWidgets(
    'Нажатие на лайк показывает Snackbar',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MovieApp(
          repository: ShowRepositoryImpl(),
        ),
      );

      // Ждём загрузки данных
      await tester.pumpAndSettle();

      // Находим первую кнопку лайка
      final likeButton = find.byType(IconButton).first;

      expect(likeButton, findsOneWidget);

      await tester.tap(likeButton);
      await tester.pump();

      // Проверяем Snackbar
      expect(find.byType(SnackBar), findsOneWidget);
    },
  );

  testWidgets(
    'Нажатие на карточку открывает окно деталей',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MovieApp(
          repository: ShowRepositoryImpl(),
        ),
      );

      // Ждём загрузки API
      await tester.pumpAndSettle();

      // Находим карточку
      final card = find.byType(Card).first;

      expect(card, findsOneWidget);

      await tester.tap(card);
      await tester.pump();

      // Проверяем, что появилось диалоговое окно
      expect(find.byType(AlertDialog), findsOneWidget);

      expect(find.text('Закрыть'), findsOneWidget);
    },
  );
}

