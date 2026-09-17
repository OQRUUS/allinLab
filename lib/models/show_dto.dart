class ShowDto {
  final int id;
  final String name;
  final String? language;
  final String? status;
  final String? premiered;
  final double? rating;
  final String? image;
  final String? summary;
  final List<String> genres;

  ShowDto({
    required this.id,
    required this.name,
    this.language,
    this.status,
    this.premiered,
    this.rating,
    this.image,
    this.summary,
    required this.genres,
  });

  factory ShowDto.fromJson(Map<String, dynamic> json) {
    final show = json['show'] as Map<String, dynamic>;

    final ratingData = show['rating'] as Map<String, dynamic>?;
    final imageData = show['image'] as Map<String, dynamic>?;

    return ShowDto(
      id: show['id'] ?? 0,
      name: show['name'] ?? 'Без названия',
      language: show['language'],
      status: show['status'],
      premiered: show['premiered'],
      rating: ratingData?['average'] != null
          ? (ratingData!['average'] as num).toDouble()
          : null,
      image: imageData?['medium'],
      summary: show['summary'],
      genres: (show['genres'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}