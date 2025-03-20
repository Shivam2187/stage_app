import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_app/core/api_service.dart';
import 'package:stage_app/core/local_storage.dart';

import 'presentation/providers/movie_provider.dart';
import 'presentation/screens/movie_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteMoviesProvider(),
        ),
      ],
      child: const MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        home: MovieListScreen(),
      ),
    );
  }
}
