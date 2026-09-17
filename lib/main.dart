import 'package:flutter/material.dart';

import 'repositories/show_repository_impl.dart';
import 'screens/home_screen.dart';

void main() {
  final repository = ShowRepositoryImpl();

  runApp(
    MovieApp(
      repository: repository,
    ),
  );
}

class MovieApp extends StatelessWidget {
  final ShowRepositoryImpl repository;

  const MovieApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Search',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),

      home: HomeScreen(
        repository: repository,
      ),
    );
  }
}