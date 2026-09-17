
import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      home: const MovieHomePage(),
    );
  }
}

class Movie {
  final String title;
  final String description;
  final String genre;
  final String year;
  final String rating;
  final IconData icon;

  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.year,
    required this.rating,
    required this.icon,
  });
}

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  final List<Movie> movies = [
    Movie(
      title: 'Интерстеллар',
      description:
          'Группа исследователей отправляется в космос через таинственную червоточину, чтобы найти новый дом для человечества.',
      genre: 'Фантастика',
      year: '2014',
      rating: '8.7',
      icon: Icons.public,
    ),
    Movie(
      title: 'Начало',
      description:
          'Профессиональный вор, способный проникать в сны людей, получает практически невыполнимое задание.',
      genre: 'Триллер',
      year: '2010',
      rating: '8.8',
      icon: Icons.psychology,
    ),
    Movie(
      title: 'Матрица',
      description:
          'Нео узнаёт, что привычный ему мир является цифровой иллюзией, созданной машинами.',
      genre: 'Боевик',
      year: '1999',
      rating: '8.7',
      icon: Icons.auto_awesome,
    ),
    Movie(
      title: 'Джокер',
      description:
          'История Артура Флека, человека, который постепенно превращается в загадочного персонажа Готэм-сити.',
      genre: 'Драма',
      year: '2019',
      rating: '8.3',
      icon: Icons.theater_comedy,
    ),
  ];

  // Список лайков для каждой карточки.
  final Set<int> likedMovies = {};

  void toggleLike(int index) {
    setState(() {
      if (likedMovies.contains(index)) {
        likedMovies.remove(index);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Фильм удалён из избранного'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        likedMovies.add(index);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Фильм добавлен в избранное'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void showMovieDetails(Movie movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            movie.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                    ),
                    child: Icon(
                      movie.icon,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Жанр: ${movie.genre}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Год: ${movie.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Рейтинг: ⭐ ${movie.rating}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Описание',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Фильмы',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isLiked = likedMovies.contains(index);

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  showMovieDetails(movie);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Иконка фильма
                      Container(
                        width: 90,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                        ),
                        child: Icon(
                          movie.icon,
                          size: 45,
                          color:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Информация о фильме
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              movie.genre,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              '${movie.year} • ⭐ ${movie.rating}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              movie.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Кнопка лайка
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                key: Key('like_$index'),
                                onPressed: () {
                                  toggleLike(index);
                                },
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                color: isLiked
                                    ? Colors.red
                                    : null,
                                tooltip: isLiked
                                    ? 'Убрать из избранного'
                                    : 'Добавить в избранное',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
