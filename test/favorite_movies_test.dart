import 'package:flutter_test/flutter_test.dart';
import 'package:stage_app/data/models/movie.dart';
import 'package:stage_app/presentation/providers/provider.dart';

void main() {
  late FavoriteMoviesProvider favoriteMoviesProvider;
  late Movie testMovie;

  setUp(() {
    favoriteMoviesProvider = FavoriteMoviesProvider();
    testMovie = Movie(
      id: 1,
      title: "Test Movie",
      moviePoster: "/test.jpg",
      overview: "Test Overview",
      genre: "Action",
      rating: "8.0",
      releaseDate: "2021-01-01",
    );
  });

  test('Toggle favorite adds movie to favorites', () {
    favoriteMoviesProvider.toggleFavorite(testMovie);
    expect(favoriteMoviesProvider.favoriteMovies.contains(testMovie), isTrue);
  });

  test('Toggle favorite removes movie from favorites', () {
    favoriteMoviesProvider.toggleFavorite(testMovie);
    favoriteMoviesProvider.toggleFavorite(testMovie);
    expect(favoriteMoviesProvider.favoriteMovies.contains(testMovie), isFalse);
  });
}
