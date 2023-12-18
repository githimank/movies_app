import '../Utils/enum_utils.dart';

import '../Network/Database/drift_database.dart';
import 'common_movies_list.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class WatchedMoviesWidget extends StatefulWidget {
  const WatchedMoviesWidget({Key? key}) : super(key: key);

  @override
  _WatchedMoviesWidgetState createState() => _WatchedMoviesWidgetState();
}

class _WatchedMoviesWidgetState extends State<WatchedMoviesWidget> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return _buildMainWidget();
  }

  Widget _buildMainWidget() {
    return StreamBuilder(
      stream: database.watchAllMovies(),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        var listOfFilteredMovies = <Movie>[];
        snapshot.data?.forEach((element) {
          if (element.isMovieWatched) {
            listOfFilteredMovies.add(element);
          }
        });

        return CommonMoviesList(
          movies: listOfFilteredMovies,
          module: EnumDashboardActiveScreenType.myWatched,
        );
      },
    );
  }
}
