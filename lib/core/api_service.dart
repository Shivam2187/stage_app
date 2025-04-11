//import 'package:dio/dio.dart';
import 'package:dio/dio.dart';

import '../data/models/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  /// Given api is not working so I have used local data
  Future<List<Movie>> fetchMovies() async {
    const url = 'https://api.themoviedb.org/3/movie/popular';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'api_key': '8109e1095288aec7bfe2b22f2f41c63e'},
      );
      final List data = response.data['results'];
      return data.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load movies- ${e.toString()}");
    }
  }
}
