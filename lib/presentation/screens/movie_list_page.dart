import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/connectivity_service.dart';
import '../../utils/constants.dart';
import '../providers/provider.dart';
import '../widgets/movie_card.dart';
import 'favourite_page.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityService().startListening();
      Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    });
  }

  @override
  void dispose() {
    ConnectivityService().dispose();
    super.dispose();
  }

  void showSnackBar() {
    if (isNetworkAvailable.value == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text(MovieConstant.noInternetConnection)),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    }
    if (isBackOnlineEnable && isNetworkAvailable.value == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text(MovieConstant.backOnline)),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    }
    needToShowNetworkSnackBar = false;
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final favoriteProvider = Provider.of<FavoriteMoviesProvider>(context);
    // Api error handling
    if (movieProvider.hasError) {
      Future.microtask(() {
        context.push(NavigationPaths.errorScreen).then((value) {
          if (value == true) {
            movieProvider.fetchMovies();
          }
        });
      });
    }

    return ValueListenableBuilder<bool?>(
      valueListenable: isNetworkAvailable,
      builder: (context, hasError, child) {
        if (needToShowNetworkSnackBar) {
          showSnackBar();
        }

        if (isNetworkAvailable.value == false) {
          return const FavouriteScreen();
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 48,
            title: const Text(
              MovieConstant.movieScreenAppbarTiltle,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
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
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: MovieConstant.searchMoviesHintText,
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
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
                            isFavourite: favoriteProvider.isFavorite(movie.id),
                            onPressed: () =>
                                favoriteProvider.toggleFavorite(movie),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
