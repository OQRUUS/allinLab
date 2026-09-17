import 'package:flutter_test/flutter_test.dart';

import 'package:alllab/main.dart';

void main() {
  test('Movie создается правильно', () {
    final movie = Movie(
      'Начало',
      8.8,
      MovieGenre.sciFi,
    );

    expect(movie.title, 'Начало');
    expect(movie.rating, 8.8);
    expect(movie.genre, MovieGenre.sciFi);
  });

  test('Рейтинг фильма обновляется', () {
    final movie = Movie(
      'Начало',
      8.8,
      MovieGenre.sciFi,
    );

    movie.updateRating(8.9);

    expect(movie.rating, 8.9);
  });

  test('Storage хранит фильмы', () {
    final storage = Storage<Movie>();

    storage.addItem(
      Movie('Начало', 8.8, MovieGenre.sciFi),
    );

    storage.addItem(
      Movie('1+1', 8.5, MovieGenre.drama),
    );

    expect(storage.items.length, 2);
  });

  test('Extension formatted форматирует рейтинг', () {
    const rating = 8.8;

    expect(rating.formatted, '8.8 / 10');
  });
}