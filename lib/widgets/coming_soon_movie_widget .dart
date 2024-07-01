import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComingSoonMovieWidget extends StatelessWidget {
  final String imageUrl;
  final String overview;
  final String logoUrl;
  final String month;
  final String day;

  const ComingSoonMovieWidget(
      {super.key,
      required this.imageUrl,
      required this.overview,
      required this.logoUrl,
      required this.month,
      required this.day});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  month,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  day,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 5),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(imageUrl: imageUrl),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.2,
                      child: CachedNetworkImage(
                        imageUrl: logoUrl,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Remind me", style: TextStyle(fontSize: 10))
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Info",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Coming on $month $day",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.left,
                      overview,
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
