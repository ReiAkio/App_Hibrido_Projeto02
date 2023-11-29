import 'package:flutter/material.dart';
import 'tmdb_service.dart';
import 'detail_screen.dart';

class TrendingPeopleTab extends StatefulWidget {
  @override
  _TrendingPeopleTabState createState() => _TrendingPeopleTabState();
}

class _TrendingPeopleTabState extends State<TrendingPeopleTab> {
  final TMDBService _tmdbService = TMDBService();
  List<dynamic> _people = [];

  @override
  void initState() {
    super.initState();
    _fetchTrendingPeople();
  }

  void _fetchTrendingPeople() async {
    var people = await _tmdbService.fetchTrendingPeople();
    setState(() {
      _people = people['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _people.length,
      itemBuilder: (context, index) {
        var person = _people[index];
        return ListTile(
          leading: Image.network(
              'https://image.tmdb.org/t/p/w500${person['profile_path']}',
              width: 50,
              height: 50),
          title: Text(person['name'] ?? 'No Name'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(item: person, searchType: 'people')),
            );
          },
        );
      },
    );
  }
}
