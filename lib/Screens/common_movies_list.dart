import 'dart:async';
import '../Utils/enum_utils.dart';

import '../Network/Database/drift_database.dart';
import '../Provider/account_provider.dart';
import '../SheetUtils/sheet_popup_utils.dart';
import '../Utils/common_empty_screen_ui.dart';
import '../Utils/color_utils.dart';
import '../Utils/list_of_objects_utils.dart';
import 'package:flutter/material.dart';
import '../CustomWidget/custom_widgets.dart';
import '../main.dart';
import 'detail_page.dart';

class CommonMoviesList extends StatefulWidget {
  final List<Movie>? movies;
  final EnumDashboardActiveScreenType? module;

  const CommonMoviesList({this.movies, this.module, Key? key})
      : super(key: key);

  @override
  _CommonMoviesListState createState() =>
      _CommonMoviesListState(movies, module);
}

class _CommonMoviesListState extends State<CommonMoviesList> {
  List<Movie>? movies;
  EnumDashboardActiveScreenType? module;
  late int _loggedInUserId;

  _CommonMoviesListState(this.movies, this.module);

  Future<void> _loadDummyDataAndSaveToDatabase() async {
    var listOfMovies = ListOfObjectsUtils().getMovieData();
    await database.batchInsert(listOfMovies);
  }

  @override
  void didUpdateWidget(covariant CommonMoviesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    movies = widget.movies;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    _loggedInUserId = AccountProvider.getLoggedInUserId(context);
    return _infiniteScrollListWidget();
  }

  Widget _infiniteScrollListWidget() {
    return module == EnumDashboardActiveScreenType.myMovies ||
            module == EnumDashboardActiveScreenType.myWatched
        ? _buildMainWidget()
        : NotificationListener(
            child: _buildMainWidget(),
            onNotification: (ScrollNotification scrollInfo) {
              double currentPixel = scrollInfo.metrics.pixels;
              if (currentPixel == scrollInfo.metrics.maxScrollExtent) {
                _loadDummyDataAndSaveToDatabase();
              }
              return true;
            },
          );
  }

  Widget _buildMainWidget() {
    if ((movies?.length ?? 0) > 0) {
      return ListView.builder(
        itemBuilder: (_, index) {
          return _commonCardUI(movies![index]);
        },
        itemCount: movies?.length ?? 0,
      );
    } else {
      return CommonEmptyScreenUI();
    }
  }

  Widget _commonCardUI(Movie movieData) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailPage(
                  movieDetail: movieData,
                )));
      },
      child: Card(
        elevation: 4.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                movieData.image,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomWidget.getTextWidget(context, movieData.name,
                        fontWeight: FontWeight.bold),
                    CustomWidget.getDefaultHeightSizedBox(),
                    CustomWidget.getTextWidget(context, movieData.detail)
                  ],
                ),
              ),
            ),
            _cardActionUI(movieData),
          ],
        ),
      ),
    );
  }

  Widget _cardActionUI(Movie movieData) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Column(
        children: [
          CustomWidget.getDefaultHeightSizedBox(),
          _commonWatchAndEditAndDeleteUI(
            icon: Icons.remove_red_eye,
            color: movieData.isMovieWatched ? Colors.green : Colors.grey,
            onTap: () {
              _eventWatch(movieData);
            },
          ),
          CustomWidget.getDefaultHeightSizedBox(),
          Visibility(
            visible: _loggedInUserId == movieData.directorID,
            child: _commonWatchAndEditAndDeleteUI(
              icon: Icons.edit,
              color: ColorUtils.greyIconColor,
              onTap: () {
                AccountProvider.checkLoginAndMoveRed(context, () {
                  SheetPopupUtils.instance.showBottomSheetAddMovie(
                    context,
                    movie: movieData,
                  );
                });
              },
            ),
          ),
          CustomWidget.getDefaultHeightSizedBox(),
          Visibility(
            visible: _loggedInUserId == movieData.directorID,
            child: _commonWatchAndEditAndDeleteUI(
              icon: Icons.delete_outline,
              color: ColorUtils.redColor,
              onTap: () {
                setState(() {
                  database.deleteMovie(movieData);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _commonWatchAndEditAndDeleteUI({IconData? icon, Color? color, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 35.0,
        height: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          size: 20.0,
        ),
      ),
    );
  }

  void _eventWatch(Movie movieDetail) async {
    Future<bool> watchQuery;
    if (movieDetail.isMovieWatched) {
      watchQuery = database.movieNotWatched(movieDetail);
    } else {
      watchQuery = database.movieWatched(movieDetail);
    }
    var isSuccess = await watchQuery;

    var toggleWatchValue =
        isSuccess ? !movieDetail.isMovieWatched : movieDetail.isMovieWatched;

    movieDetail = movieDetail.copyWith(isMovieWatched: toggleWatchValue);

    setState(() {});
  }
}
