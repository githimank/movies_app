import '../Utils/enum_utils.dart';

import '../Network/Database/drift_database.dart';
import 'common_movies_list.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AllMoviesWidget extends StatefulWidget {
  const AllMoviesWidget({Key? key}) : super(key: key);

  @override
  _AllMoviesWidgetState createState() => _AllMoviesWidgetState();
}

class _AllMoviesWidgetState extends State<AllMoviesWidget> {
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
        return CommonMoviesList(
          movies: snapshot.data,
          module: EnumDashboardActiveScreenType.all,
        );
      },
    );
  }
}
