import 'package:flutter/material.dart';

import '../models/show_dto.dart';
import '../repositories/show_repository.dart';

class HomeScreen extends StatefulWidget {
  final ShowRepository repository;

  const HomeScreen({
    super.key,
    required this.repository,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController =
      TextEditingController();

  List<ShowDto> shows = [];

  final Set<int> likedShows = {};

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    searchController.text = 'friends';

    searchShows();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> searchShows() async {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        shows = [];
        errorMessage = 'Введите название сериала';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await widget.repository.searchShows(query);

      setState(() {
        shows = result;
      });
    } catch (e) {
      setState(() {
        errorMessage =
            'Не удалось получить данные.\n$e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleLike(int id, String name) {
    setState(() {
      if (likedShows.contains(id)) {
        likedShows.remove(id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$name убран из избранного',
            ),
          ),
        );
      } else {
        likedShows.add(id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$name добавлен в избранное ❤️',
            ),
          ),
        );
      }
    });
  }

  void showDetails(ShowDto show) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(show.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                if (show.image != null)
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(16),
                    child: Image.network(
                      show.image!,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 60,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 16),

                Text(
                  'Жанр',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  show.genres.isEmpty
                      ? 'Не указан'
                      : show.genres.join(', '),
                ),

                const SizedBox(height: 16),

                Text(
                  'Рейтинг',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  show.rating != null
                      ? '⭐ ${show.rating}'
                      : 'Нет рейтинга',
                ),

                const SizedBox(height: 16),

                Text(
                  'Язык',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  show.language ?? 'Не указан',
                ),

                const SizedBox(height: 16),

                Text(
                  'Статус',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  show.status ?? 'Не указан',
                ),

                const SizedBox(height: 16),

                Text(
                  'Описание',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  removeHtmlTags(
                    show.summary ?? 'Описание отсутствует',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  String removeHtmlTags(String text) {
    return text.replaceAll(
      RegExp(r'<[^>]*>'),
      '',
    );
  }

  Widget buildShowCard(ShowDto show) {
    final isLiked = likedShows.contains(show.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: InkWell(
        onTap: () {
          showDetails(show);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Постер
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(14),
                child: show.image != null
                    ? Image.network(
                        show.image!,
                        width: 110,
                        height: 160,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            width: 110,
                            height: 160,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 40,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 110,
                        height: 160,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.movie,
                          size: 50,
                        ),
                      ),
              ),

              const SizedBox(width: 14),

              // Информация
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.name,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    if (show.genres.isNotEmpty)
                      Text(
                        show.genres.join(' • '),
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                    const SizedBox(height: 8),

                    Text(
                      show.rating != null
                          ? '⭐ ${show.rating}'
                          : '⭐ Нет рейтинга',
                    ),

                    const SizedBox(height: 6),

                    Text(
                      show.premiered ??
                          'Дата неизвестна',
                    ),

                    const SizedBox(height: 8),

                    Text(
                      removeHtmlTags(
                        show.summary ??
                            'Описание отсутствует',
                      ),
                      maxLines: 4,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Align(
                      alignment:
                          Alignment.centerRight,
                      child: IconButton(
                        key: Key(
                          'like_${show.id}',
                        ),
                        onPressed: () {
                          toggleLike(
                            show.id,
                            show.name,
                          );
                        },
                        icon: Icon(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        color: isLiked
                            ? Colors.red
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Поиск
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              textInputAction:
                  TextInputAction.search,
              onSubmitted: (_) {
                searchShows();
              },
              decoration: InputDecoration(
                hintText:
                    'Введите название сериала',
                prefixIcon:
                    const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: searchShows,
                  icon:
                      const Icon(Icons.arrow_forward),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(),
                  )
                : errorMessage != null
                    ? Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(24),
                          child: Text(
                            errorMessage!,
                            textAlign:
                                TextAlign.center,
                          ),
                        ),
                      )
                    : shows.isEmpty
                        ? const Center(
                            child: Text(
                              'Ничего не найдено',
                            ),
                          )
                        : ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            itemCount: shows.length,
                            itemBuilder:
                                (context, index) {
                              return buildShowCard(
                                shows[index],
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}