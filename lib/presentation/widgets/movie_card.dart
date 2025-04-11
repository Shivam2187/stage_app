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
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl:
                      MovieConstant.baseImageUrl + (movie.posterPath ?? ''),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
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
                          movie.title ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              MovieConstant.ratingText,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              movie.voteAverage
                                      ?.toStringAsPrecision(2)
                                      .toString() ??
                                  '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              size: 12,
                            )
                          ],
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
