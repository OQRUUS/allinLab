import '../models/show_dto.dart';

abstract class ShowApi {
  Future<List<ShowDto>> searchShows(String query);
}