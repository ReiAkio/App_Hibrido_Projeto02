import 'package:http/http.dart' as http;
import 'dart:convert';

class TMDBService {
  final String apiKey = '8bb76632f4365c4e958431e7356b413e';

  Future<dynamic> fetchTrendingMovies() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<dynamic> fetchTrendingTV() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/trending/tv/day?api_key=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load TV shows');
    }
  }

  Future<dynamic> fetchTrendingPeople() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/trending/person/day?api_key=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<dynamic> search(String query, String type) async {
    String typePath = type == 'movies'
        ? 'movie'
        : type == 'tv'
            ? 'tv'
            : 'person';
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/$typePath?api_key=$apiKey&query=$query');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search');
    }
  }
}
