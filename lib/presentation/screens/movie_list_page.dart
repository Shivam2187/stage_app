import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stage_app/data/models/movie.dart';


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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text(
          MovieConstant.movieScreenAppbarTiltle,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
      ),
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.hasError
              ? const Center(
                  child: Text(MovieConstant.failedtoload,
                      style: TextStyle(color: Colors.black)))
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
                          childAspectRatio: 0.6,
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
        context.push('/movieDetailsScreen', extra: movie);
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: movie.moviePoster,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          movie.genre,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black),
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
            ),
          ],
        ),
      ),
    );
  }
}
