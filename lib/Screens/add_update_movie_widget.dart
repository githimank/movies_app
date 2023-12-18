import 'dart:math';
import '../Network/Database/drift_database.dart';
import '../Utils/size_utils.dart';
import '../Utils/toast_utils.dart';
import 'package:flutter/material.dart';
import '../CustomWidget/custom_widgets.dart';
import 'select_image.dart';
import '../Utils/app_utils.dart';

import '../main.dart';

class AddUpdateMovieWidget extends StatefulWidget {
  final Movie? movie;

  const AddUpdateMovieWidget({this.movie, Key? key}) : super(key: key);

  @override
  _AddUpdateMovieWidgetState createState() => _AddUpdateMovieWidgetState(movie);
}

class _AddUpdateMovieWidgetState extends State<AddUpdateMovieWidget> {
  Movie? movie;

  _AddUpdateMovieWidgetState(this.movie);

  String? assetImage;
  //String? image;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  final _defaultPadding = SizeUtils.instance.appDefaultSpacing;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: movie?.name);
    _descController = TextEditingController(text: movie?.detail);
    assetImage = movie?.image;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: _buildMainWidget(),
        ),
      ),
    );
  }

  Widget _buildMainWidget() {
    return Container(
      padding: EdgeInsets.all(_defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                  )),
              const Text(
                "Add Movie",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
            ],
          ),
          CustomWidget.getDefaultHeightSizedBox(),
          _buildImageWidget(),
          CustomWidget.getDefaultHeightSizedBox(),
          CustomWidget.getTextField(
              context, _nameController, "Add movie name here",
              onChange: (value) {
            _nameController.text = value;
          }),
          CustomWidget.getDefaultHeightSizedBox(),
          CustomWidget.getTextField(
              context, _descController, "Add Director / Description here",
              onChange: (value) {
            _descController.text = value;
          }),
          CustomWidget.getDefaultHeightSizedBox(),
          //  _selectCategoryDropDownWidget(),
          CustomWidget.getDefaultHeightSizedBox(height: 48.0),
          _buildSaveButtonWidget()
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    return GestureDetector(
      child: assetImage != null
          ? SizedBox(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                assetImage!,
                fit: BoxFit.fill,
              ))
          : Container(
              padding: EdgeInsets.all(_defaultPadding),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(24.0),
              ),
              child:
                  CustomWidget.getTextWidget(context, "Select image from here"),
            ),
      onTap: () async {
        // Get result from Select Image screen...
        String? result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SelectImage()))
            as String?;
        if (result != null) {
          assetImage = result;
          AppUtils.refreshCurrentState(this);
        }
      },
    );
  }

  Widget _buildSaveButtonWidget() {
    return CustomWidget.getRoundedButtonWidget(context, 'Save', onTap: () {
      _onSaveClickEvent();
    });
  }

  void _onSaveClickEvent() {
    if (assetImage == null) {
      ToastUtils.show('Please select Image');
      return;
    } else if (_nameController.text == '') {
      ToastUtils.show('Please Enter Name');
      return;
    } else if (_descController.text == '') {
      ToastUtils.show('Please Enter Director, Description');
      return;
    }

    var name = _nameController.text;
    var desc = _descController.text;

    if (movie?.id != null) {
      movie = movie!.copyWith(name: name, detail: desc, image: assetImage!);
      database.updateMovie(movie!);
    } else {
      var addNewCardItem = Movie(
        id: Random().nextInt(100000),
        directorID: 1,
        name: name,
        detail: desc,
        image: assetImage!,
        isMovieWatched: false,
      );

      database.insertMovie(addNewCardItem);
    }

    Navigator.pop(context);
  }
}
