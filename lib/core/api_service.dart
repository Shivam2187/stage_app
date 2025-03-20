import 'package:dio/dio.dart';
import '../data/models/movie.dart';
import '../utils/constants.dart';

class ApiService {
  //final Dio _dio = Dio();

  Future<List<Movie>> fetchMovies() async {
    try {
      // final response = await _dio.get(
      //   url,
      //   queryParameters: {'api_key': 'apiKey'},
      // );
      // final List data = response.data['results'];
      // return data.map((json) => Movie.fromJson(json)).toList();

      return MovieConstant.movies;
    } catch (e) {
      throw Exception("Failed to load movies");
    }
  }
}
