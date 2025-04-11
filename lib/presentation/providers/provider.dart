// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stage_app/core/api_service.dart';
import 'package:stage_app/data/models/movie.dart';
import 'package:stage_app/utils/constants.dart';

import '../../core/local_storage.dart';
import '../../core/locator.dart';

ValueNotifier<bool?> isNetworkAvailable = ValueNotifier<bool?>(null);
bool isBackOnlineEnable = false;
bool needToShowNetworkSnackBar = true;

class MovieProvider with ChangeNotifier {
  MovieProvider();

  final ApiService apiService = locator.get<ApiService>();
  final List<Movie> _totalLoadedMovies = [];
  List<Movie> preFetchMovies = [];
  String _searchQuery = '';
  List<Movie> _favoriteMovies = LocalStorage.getFavorites();
  bool isLoading = false;
  bool hasError = false;
  String currentPageNumber = '1';

  List<Movie> get movies => _searchQuery.isEmpty
      ? _totalLoadedMovies
      : _totalLoadedMovies.where((movie) {
          if (movie.title == null) {
            return false;
          }
          return movie.title!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
        }).toList();

  List<Movie> get favoriteMovies => _favoriteMovies.where((movie) {
        if (movie.title == null) {
          return false;
        }
        return movie.title!.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();

  Future<void> fetchMovies({bool isPrefetch = false,}) async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final currentMovie =
          await apiService.fetchMovies(MovieConstant.apiKey, currentPageNumber);

      if (isPrefetch) {
        if (currentMovie.isListNotEmptyOrNull()) {
          preFetchMovies
            ..clear()
            ..addAll(currentMovie);
        }
      } else {
        if (currentMovie.isListNotEmptyOrNull()) {
          _totalLoadedMovies.addAll(currentMovie);
        }
      }

      currentPageNumber =
          ((int.tryParse(currentPageNumber) ?? 0) + 1).toString();
    } catch (e) {
      hasError = true;
      print(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreMovies() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      if (preFetchMovies.isListNotEmptyOrNull()) {
        _totalLoadedMovies.addAll(preFetchMovies);
        currentPageNumber =
            ((int.tryParse(currentPageNumber) ?? 0) + 1).toString();
        fetchMovies(isPrefetch: true);
      }
    } catch (e) {
      hasError = true;
      currentPageNumber =
          ((int.tryParse(currentPageNumber) ?? 0) - 1).toString();
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
