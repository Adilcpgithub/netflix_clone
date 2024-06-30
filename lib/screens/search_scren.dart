import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/models/upcoming_movie.dart';
import 'package:netflix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchMovieModel? searchMovieModel;
  late Future<UpcomingMovieModel> popularMovies;

  void search(String query) {
    apiServices.getSearchedMovies(query).then((results) {
      setState(() {
        searchMovieModel = results;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getNowPlayingMovies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(10),
                  controller: searchController,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        searchMovieModel = null;
                      });
                    } else {
                      search(value);
                    }
                  },
                ),
              ),
              searchController.text.isEmpty
                  ? FutureBuilder<UpcomingMovieModel>(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.results.isEmpty) {
                          return Center(child: Text('No results found.'));
                        } else {
                          var data = snapshot.data!.results;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Text(
                                '  Top Searches',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height:
                                    600, // Increased height for the ListView
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(5),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.length,
                                  physics:
                                      AlwaysScrollableScrollPhysics(), // Enable scrolling
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          height: 150,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Image.network(
                                            "${imageUrl}${data[index].posterPath}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                            width: 260,
                                            child: Text(
                                              data[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 18),
                                            ))
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    )
                  : searchMovieModel == null
                      ? SizedBox.shrink()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchMovieModel!.results.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 5,
                            childAspectRatio: 1.2 / 2,
                          ),
                          itemBuilder: (context, index) {
                            var movie = searchMovieModel!.results[index];
                            return Column(
                              children: [
                                movie.backdropPath == null
                                    ? Image.asset('assets/netflix.png')
                                    : CachedNetworkImage(
                                        imageUrl:
                                            '${imageUrl}${movie.backdropPath}',
                                        height: 170,
                                      ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    movie.originalTitle ?? 'No title',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
