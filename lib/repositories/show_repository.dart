import '../models/show_dto.dart';

abstract class ShowRepository {
  Future<List<ShowDto>> searchShows(String query);
}