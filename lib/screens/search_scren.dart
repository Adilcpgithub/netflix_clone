import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/movie_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchMovieModel? searchMovieModel;
  late Future<MovieCardWidget> popularMovies;

  void search(String query) {
    apiServices.getSearchedMovies(query).then((results) {
      setState(() {
        searchMovieModel = results;
      });
    });
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
                  } else {
                    search(searchController.text);
                  }
                },
              ),
            ),
            searchController.text.isEmpty
                ? FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data?.results;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              headLineText,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.network(
                                        "${imageUrl}${data[index].posterPath}"),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    })
                : searchMovieModel == null
                    ? SizedBox.shrink()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchMovieModel!.results.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 5,
                            childAspectRatio: 1.2 / 2),
                        itemBuilder: (contex, index) {
                          return Column(children: [
                            searchMovieModel?.results[index].backdropPath ==
                                    null
                                ? Image.asset('assets/netflix.png')
                                : CachedNetworkImage(
                                    imageUrl:
                                        '${imageUrl}${searchMovieModel!.results[index].backdropPath}',
                                    height: 170),
                            SizedBox(
                              width: 100,
                              child: Text(
                                '${searchMovieModel!.results[index].originalTitle}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ]);
                        })
          ],
        ),
      )),
    );
  }
}
