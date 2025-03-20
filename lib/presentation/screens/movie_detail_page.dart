import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_app/data/models/movie.dart';

import '../providers/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteMoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500${movie.moviePoster}",
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(movie.overview, textAlign: TextAlign.center),
          ),
          IconButton(
            icon: Icon(
              favoriteProvider.isFavorite(movie.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
              size: 32,
            ),
            onPressed: () => favoriteProvider.toggleFavorite(movie),
          ),
        ],
      ),
    );
  }
}
