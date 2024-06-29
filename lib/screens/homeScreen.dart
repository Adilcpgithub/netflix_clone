import 'package:flutter/material.dart';
import 'package:netflix_clone/models/topratedtv.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/custom_carousel.dart';
import 'package:netflix_clone/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TopRatedTvShowsModel> topRated;

  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovies();
    topRated = apiServices.getTopRatedShows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset(
            'assets/logo.png',
            height: 50,
            width: 120,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {},
                  child: const Icon(
                    size: 30,
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: topRated,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCurouselSlider(data: snapshot.data!);
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: upcomingFuture, headLineText: 'Upcoming Movies'),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: nowPlayingFuture, headLineText: 'Now Playing'),
              )
            ],
          ),
        ));
  }
}
