import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'App_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  List<String> items = ['Damascus', 'Customer'];
  RangeValues values_p = RangeValues(0.0, 100.0);
  RangeValues values_s = RangeValues(0.0, 1000);
  List<String> types = ['House', 'Chalet', 'Market'];
  int s = 0;
  int p = 0;
  int a = 0;
  void propertytype(String index) {
    p = types.indexOf(index);
    emit(add_type());
  }

  void searchindex(String index) {
    s = items.indexOf(index);
    emit(Searchdrop());
  }

  void searchprice(RangeValues num) {
    values_p = num;
    emit(Searchdrop());
  }

  void searchspace(RangeValues num) {
    values_s = num;
    emit(Searchdrop());
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  Future selectimage() async {
    final List<XFile> selectedimage = await imagePicker.pickMultiImage();
    try {
      if (selectedimage.isNotEmpty) {
        imageFileList.addAll(selectedimage);
      } else {
        imageFileList.clear();
      }
      emit(add_image());
    } on PlatformException catch (e) {
      print(e);
    }
  }

  List<ContactModel> contact = [
    ContactModel('Gardin', false),
    ContactModel('Swimming pool', false),
    ContactModel('Porch', false),
    ContactModel('Parking', false),
    ContactModel('Children is pool', false),
    ContactModel('Solar energy', false),
  ];
  List<ContactModel> selectedcontact = [];
  void feature(String name, bool isselected, int index) {
    contact[index].isselected = !contact[index].isselected;
    if (contact[index].isselected == true) {
      selectedcontact.add(ContactModel(name, true));
    } else if (contact[index].isselected == false) {
      selectedcontact
          .removeWhere((element) => element.name == contact[index].name);
    }
    emit(add_feature());
  }

/////show
  List<String> aa = [
    '1/9/2023',
    '2/9/2023',
    '3/9/2023',
    '4/9/2023',
    '5/9/2023',
    '6/9/2023',
    '7/9/2023',
    '8/9/2023',
    '9/9/2023',
    '10/9/2023',
    '11/9/2023',
    '12/9/2023',
    '13/9/2023',
    '14/9/2023',
    '15/9/2023',
    '16/9/2023',
    '17/9/2023',
    '18/9/2023',
    '19/9/2023',
    '20/9/2023',
  ];
  void reservation(String index) {
    a = aa.indexOf(index);
    emit(add_type());
  }
}

class ContactModel {
  String name;
  bool isselected;
  ContactModel(this.name, this.isselected);
}
