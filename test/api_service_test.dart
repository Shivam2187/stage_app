import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:stage_app/core/api_service.dart';
import 'package:stage_app/data/models/movie.dart';

import 'api_service_test.mocks.dart'; // ✅ Import generated mock file

@GenerateMocks([Dio]) // ✅ Generate mock for Dio
void main() {
  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio(); // ✅ Create MockDio instance
    apiService = ApiService(); // ✅ Pass MockDio to ApiService
  });

  test('Fetch movies returns a list of movies', () async {
    // Mock response
    final mockResponse = {
      "results": [
        {
          "id": 1,
          "title": "Inception",
          "poster_path": "/inception.jpg",
          "overview": "A mind-bending thriller"
        }
      ]
    };

    when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response(
              data: mockResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ));

    final movies = await apiService.fetchMovies();

    expect(movies, isA<List<Movie>>());
    expect(movies.length, 1);
    expect(movies[0].title, "Inception");
  });

  test('Fetch movies throws exception on failure', () async {
    when(mockDio.get(any)).thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      error: "Network error",
    ));

    expect(() => apiService.fetchMovies(), throwsException);
  });
}
