enum MovieGenre { action, drama, comedy, sciFi }

class Movie {
  String title;
  double rating;
  MovieGenre genre;

  Movie(this.title, this.rating, this.genre);

  void updateRating(double newRating) {
    rating = newRating;
  }
}

class Storage<T> {
  List<T> items = [];

  void addItem(T item) {
    items.add(item);
  }

  void processAll(void Function(T) action) {
    for (var item in items) {
      action(item);
    }
  }
}

extension RatingFormatter on double {
  String get formatted {
    return '${toStringAsFixed(1)} / 10';
  }
}

Future<void> simulateDatabaseSave(Movie movie) async {
  print('Сохраняем фильм "${movie.title}" в базу данных');

  await Future.delayed(const Duration(seconds: 1));

  print('Фильм "${movie.title}" успешно сохранен');
}

void main() async {
  print('Лабораторная 2: Система управления фильмами');

  Storage<Movie> storage = Storage<Movie>();

  storage.addItem(Movie('Начало', 8.8, MovieGenre.sciFi));
  storage.addItem(Movie('Темный рыцарь', 9.0, MovieGenre.action));
  storage.addItem(Movie('1+1', 8.5, MovieGenre.drama));

  print('\nСписок фильмов до обновления');

  storage.items.forEach((movie) {
    print(
      '🎥 ${movie.title} | '
      'Жанр: ${movie.genre.name} | '
      'Рейтинг: ${movie.rating.formatted}',
    );
  });

  print('\nНачало сохранения в базу');

  for (var movie in storage.items) {
    movie.updateRating(movie.rating + 0.1);
    await simulateDatabaseSave(movie);
  }

  print('\nИтоговый список фильмов');

  storage.processAll((movie) {
    print(
      '🌟 ${movie.title} | '
      'Новый рейтинг: ${movie.rating.formatted}',
    );
  });
}
