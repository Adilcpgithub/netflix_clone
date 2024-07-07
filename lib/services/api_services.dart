import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/movie_detailed_model.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/models/topratedtv.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
import 'package:netflix_clone/common/utils.dart';

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Success ");
      return UpcomingMovieModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Failed to load upcoming movies');
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Success ");
      return UpcomingMovieModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Failed to load now playing movies');
  }

  Future<TopRatedTvShowsModel> getTopRatedShows() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Success ");
      return TopRatedTvShowsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcomeing movies");
  }

  Future<SearchMovieModel> getSearchedMovies(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";
    print('search url is : $url');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOTNlNjZiNDAyNWExMTY2NjdjOWI1OWYzNTllNzYwMCIsInN1YiI6IjY2NzUwN2E0NzhiMzlmNTM4MjcxZTQyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Zo-2XcGpJEwgnROXkU19SLnhF4iUnoREc8JZKoTcOf8"
    });
    if (response.statusCode == 200) {
      print("Success ");
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load searched movies");
  }

  Future<MovieRecomendationModel> getPopularMovies() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Success ");
      return MovieRecomendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies");
  }
}
