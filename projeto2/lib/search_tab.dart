import 'package:flutter/material.dart';
import 'tmdb_service.dart';
import 'detail_screen.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TMDBService _tmdbService = TMDBService();
  String _searchType = 'movies';
  List<dynamic> _searchResults = [];
  String _searchQuery = '';

  void _performSearch() async {
    var results = await _tmdbService.search(_searchQuery, _searchType);
    setState(() {
      _searchResults = results['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) => _searchQuery = value,
          onSubmitted: (value) => _performSearch(),
          decoration: InputDecoration(
            labelText: 'Search',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: _performSearch,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<String>(
              value: 'movies',
              groupValue: _searchType,
              onChanged: (value) {
                setState(() {
                  _searchType = value!;
                });
              },
            ),
            Text('Movies'),
            Radio<String>(
              value: 'tv',
              groupValue: _searchType,
              onChanged: (value) {
                setState(() {
                  _searchType = value!;
                });
              },
            ),
            Text('TV'),
            Radio<String>(
              value: 'people',
              groupValue: _searchType,
              onChanged: (value) {
                setState(() {
                  _searchType = value!;
                });
              },
            ),
            Text('People'),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              var item = _searchResults[index];
              String imageUrl;

              // Definindo a URL da imagem com base no tipo de busca
              if (_searchType == 'movies') {
                imageUrl = item['poster_path'] != null
                    ? 'https://image.tmdb.org/t/p/w500${item['poster_path']}'
                    : '';
              } else if (_searchType == 'tv') {
                imageUrl = item['backdrop_path'] != null
                    ? 'https://image.tmdb.org/t/p/w500${item['backdrop_path']}'
                    : '';
              } else {
                // Para pessoas
                imageUrl = item['profile_path'] != null
                    ? 'https://image.tmdb.org/t/p/w500${item['profile_path']}'
                    : '';
              }

              return ListTile(
                leading: imageUrl.isNotEmpty
                    ? Image.network(imageUrl, width: 50, height: 50)
                    : SizedBox.shrink(),
                title: Text(_searchType == 'movies'
                    ? item['title'] ?? 'No Title'
                    : item['name'] ?? 'No Name'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(item: item, searchType: _searchType)),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
