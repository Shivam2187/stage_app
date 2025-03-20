import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String moviePoster;

  @HiveField(3)
  final String overview;

  @HiveField(4)
  bool isFavorite;

  @HiveField(5)
  final String genre;

  @HiveField(6)
  final String rating;

  @HiveField(7)
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.moviePoster,
    required this.overview,
    this.isFavorite = false,
    required this.genre,
    required this.rating,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
