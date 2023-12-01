import 'package:flutter/material.dart';
import 'tmdb_service.dart';
import 'detail_screen.dart';

class TrendingTVTab extends StatefulWidget {
  @override
  _TrendingTVTabState createState() => _TrendingTVTabState();
}

class _TrendingTVTabState extends State<TrendingTVTab> {
  final TMDBService _tmdbService = TMDBService();
  List<dynamic> _tvShows = [];

  @override
  void initState() {
    super.initState();
    _fetchTrendingTVShows();
  }

  void _fetchTrendingTVShows() async {
    try {
      var tvShows = await _tmdbService.fetchTrendingTV();
      setState(() {
        _tvShows = tvShows['results'];
      });
    } catch (e) {
      print('Erro ao buscar séries de TV: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tvShows.length,
      itemBuilder: (context, index) {
        var tvShow = _tvShows[index];
        Widget imageWidget = tvShow['backdrop_path'] != null
            ? Image.network(
                'https://image.tmdb.org/t/p/w500${tvShow['backdrop_path']}',
                width: 50,
                height: 50,
                fit: BoxFit.cover)
            : SizedBox
                .shrink(); // Não exibe nada se a imagem não estiver disponível

        return ListTile(
          leading: imageWidget,
          title: Text(tvShow['name'] ?? 'No Name'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(item: tvShow, searchType: 'tv')),
            );
          },
        );
      },
    );
  }
}
