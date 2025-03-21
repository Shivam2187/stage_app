import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stage_app/data/models/movie.dart';

import '../../utils/constants.dart';
import '../providers/provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isFavourite;
  final void Function() onPressed;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isFavourite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (isNetworkAvailable.value ?? false) {
          context.push(NavigationPaths.movieDetailsScreen, extra: movie);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(MovieConstant.noInternetConnection),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
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
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: onPressed,
                    //,
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
