import 'package:flutter/material.dart';
import 'package:stage_app/core/api_service.dart';
import 'package:stage_app/data/models/movie.dart';

import '../../core/local_storage.dart';
import '../../core/locator.dart';

class MovieProvider with ChangeNotifier {
  final ApiService apiService = locator.get<ApiService>();
  List<Movie> _movies = [];
  String _searchQuery = '';

  MovieProvider();

  List<Movie> get movies => _searchQuery.isEmpty
      ? _movies
      : _movies
          .where((movie) =>
              movie.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

  bool isLoading = false;
  bool hasError = false;

  Future<void> fetchMovies() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      _movies = await apiService.fetchMovies();
    } catch (e) {
      hasError = true;
    }

    isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}

class FavoriteMoviesProvider with ChangeNotifier {
  List<Movie> _favoriteMovies = LocalStorage.getFavorites();

  List<Movie> get favoriteMovies => _favoriteMovies;

  void toggleFavorite(Movie movie) {
    movie.isFavorite = !movie.isFavorite;
    if (movie.isFavorite) {
      LocalStorage.saveFavorite(movie);
      _favoriteMovies = [..._favoriteMovies, movie];
    } else {
      LocalStorage.removeFavorite(movie.id);
      _favoriteMovies = _favoriteMovies.where((m) => m.id != movie.id).toList();
    }
    notifyListeners();
  }

  bool isFavorite(int movieId) {
    return _favoriteMovies.any((movie) => movie.id == movieId);
  }
}
