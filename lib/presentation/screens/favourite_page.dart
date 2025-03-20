import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_app/presentation/widgets/movie_card.dart';

import '../../utils/constants.dart';
import '../providers/movie_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: favoriteProvider.favoriteMovies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final movie = favoriteProvider.favoriteMovies[index];
                return MovieCard(
                  movie: movie,
                  isFavourite: favoriteProvider.isFavorite(movie.id),
                  onPressed: () => favoriteProvider.toggleFavorite(movie),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
