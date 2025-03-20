import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stage_app/data/models/movie.dart';

import '../providers/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.8,
                  child: CachedNetworkImage(
                    imageUrl: movie.moviePoster,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      // Add share functionality here
                    },
                  ),
                ),
              ],
            ),
            MovieImageWithRating(
              movie: movie,
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child:
                  Text(movie.overview, style: const TextStyle(color: Colors.black)),
            ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class MovieImageWithRating extends StatelessWidget {
  final Movie movie;
  const MovieImageWithRating({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteMoviesProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: .7,
              child: CachedNetworkImage(
                imageUrl: movie.moviePoster,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const SizedBox(height: 48),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(movie.title, style: const TextStyle(color: Colors.black)),
              Text(movie.releaseDate,
                  style: const TextStyle(color: Colors.black)),
              Text(movie.rating, style: const TextStyle(color: Colors.black)),
            ],
          ),
          const SizedBox(width: 36),
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
