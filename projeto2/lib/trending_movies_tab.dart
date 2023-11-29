import 'package:flutter/material.dart';
import 'tmdb_service.dart';
import 'detail_screen.dart';

class TrendingMoviesTab extends StatefulWidget {
  @override
  _TrendingMoviesTabState createState() => _TrendingMoviesTabState();
}

class _TrendingMoviesTabState extends State<TrendingMoviesTab> {
  final TMDBService _tmdbService = TMDBService();
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchTrendingMovies();
  }

  void _fetchTrendingMovies() async {
    var movies = await _tmdbService.fetchTrendingMovies();
    setState(() {
      _movies = movies['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        var movie = _movies[index];
        return ListTile(
          leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
              width: 50,
              height: 50),
          title: Text(movie['title'] ?? 'No Title'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(item: movie, searchType: 'movies')),
            );
          },
        );
      },
    );
  }
}
