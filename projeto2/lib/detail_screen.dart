import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final dynamic item;
  final String searchType;

  DetailScreen({Key? key, required this.item, required this.searchType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://image.tmdb.org/t/p/w500';
    String title = '';
    List<Widget> details = [];

    if (searchType == 'movies') {
      imageUrl += item['poster_path'] ?? '';
      title = item['title'] ?? 'No Title';
      details.add(Text(item['overview'] ?? 'No Description'));
      // Adicione mais detalhes sobre filmes aqui
    } else if (searchType == 'tv') {
      imageUrl += item['backdrop_path'] ?? '';
      title = item['name'] ?? 'No Name';
      details.add(Text(item['overview'] ?? 'No Description'));
      // Adicione mais detalhes sobre séries de TV aqui
    } else if (searchType == 'people') {
      imageUrl += item['profile_path'] ?? '';
      title = item['name'] ?? 'No Name';
      details.add(Text('Known for: ${item['known_for_department']}'));
      // Adicione mais detalhes sobre pessoas aqui
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl.isNotEmpty
                ? Image.network(imageUrl, fit: BoxFit.cover)
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: details),
            ),
          ],
        ),
      ),
    );
  }
}
