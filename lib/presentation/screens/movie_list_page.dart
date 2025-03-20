import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_app/data/models/movie.dart';

import 'package:stage_app/presentation/screens/movie_detail_page.dart';

import '../../utils/constants.dart';
import '../providers/movie_provider.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final favoriteProvider = Provider.of<FavoriteMoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(MovieConstant.movieScreenAppbarTiltle)),
        backgroundColor: Colors.red,
      ),
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.hasError
              ? const Center(child: Text(MovieConstant.failedtoload))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: MovieConstant.searchMoviesHintText,
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 12.0)),
                        onChanged: movieProvider.setSearchQuery,
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: movieProvider.movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final movie = movieProvider.movies[index];
                          return MovieCard(
                            movie: movie,
                            favoriteProvider: favoriteProvider,
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final FavoriteMoviesProvider favoriteProvider;

  const MovieCard({
    super.key,
    required this.movie,
    required this.favoriteProvider,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500${movie.moviePoster}",
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          movie.genre,
                          style: const TextStyle(fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 24,
                    icon: Icon(
                      favoriteProvider.isFavorite(movie.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () => favoriteProvider.toggleFavorite(movie),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
