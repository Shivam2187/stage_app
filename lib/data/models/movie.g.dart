// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      id: fields[0] as int,
      title: fields[1] as String,
      moviePoster: fields[2] as String,
      overview: fields[3] as String,
      isFavorite: fields[4] as bool,
      genre: fields[5] as String,
      rating: fields[6] as String,
      releaseDate: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.moviePoster)
      ..writeByte(3)
      ..write(obj.overview)
      ..writeByte(4)
      ..write(obj.isFavorite)
      ..writeByte(5)
      ..write(obj.genre)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.releaseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      moviePoster: json['moviePoster'] as String,
      overview: json['overview'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      genre: json['genre'] as String,
      rating: json['rating'] as String,
      releaseDate: json['releaseDate'] as String,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'moviePoster': instance.moviePoster,
      'overview': instance.overview,
      'isFavorite': instance.isFavorite,
      'genre': instance.genre,
      'rating': instance.rating,
      'releaseDate': instance.releaseDate,
    };
