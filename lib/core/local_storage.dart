import 'package:hive_flutter/hive_flutter.dart';
import '../data/models/movie.dart';

class LocalStorage {
  static late Box<Movie> movieBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());
    movieBox = await Hive.openBox<Movie>('favorites');
  }

  static List<Movie> getFavorites() {
    return movieBox.values.toList();
  }

  static void saveFavorite(Movie movie) {
    movieBox.put(movie.id, movie);
  }

  static void removeFavorite(int id) {
    movieBox.delete(id);
  }
}
