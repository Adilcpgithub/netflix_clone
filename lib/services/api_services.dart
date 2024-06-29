import 'dart:convert';
import 'dart:math';

import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success" as num);
      return UpcomingMovieModel.fromJson(
          jsonEncode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Falied to load upcoming movies');
  }
}
