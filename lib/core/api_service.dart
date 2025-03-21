//import 'package:dio/dio.dart';
import '../data/models/movie.dart';
import '../utils/constants.dart';

class ApiService {
  //final Dio _dio = Dio();

  /// Given api is not working so I have used local data
  Future<List<Movie>> fetchMovies() async {
    try {
      // final response = await _dio.get(
      //   url,
      //   queryParameters: {'api_key': 'apiKey'},
      // );
      // final List data = response.data['results'];
      // return data.map((json) => Movie.fromJson(json)).toList();

      await Future.delayed(const Duration(milliseconds: 200));

      return MovieConstant.movies;
    } catch (e) {
      throw Exception("Failed to load movies- ${e.toString()}");
    }
  }
}
