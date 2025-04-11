// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stage_app/core/api_service.dart';
import 'package:stage_app/data/models/movie.dart';

import '../../core/local_storage.dart';
import '../../core/locator.dart';

ValueNotifier<bool?> isNetworkAvailable = ValueNotifier<bool?>(null);
bool isBackOnlineEnable = false;
bool needToShowNetworkSnackBar = true;

class MovieProvider with ChangeNotifier {
  MovieProvider();

  final ApiService apiService = locator.get<ApiService>();
  List<Movie> _movies = [];
  String _searchQuery = '';
  List<Movie> _favoriteMovies = LocalStorage.getFavorites();
  bool isLoading = false;
  bool hasError = false;

  List<Movie> get movies => _searchQuery.isEmpty
      ? _movies
      : _movies
          .where((movie) =>
              movie.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

  List<Movie> get favoriteMovies => _favoriteMovies
      .where((movie) =>
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  Future<void> fetchMovies() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      _movies = await apiService.fetchMovies();
    } catch (e) {
      hasError = true;
      print(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

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
