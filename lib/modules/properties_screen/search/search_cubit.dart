import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/properties_screen/search/search_state.dart';
import 'package:untitled/shared/models/property_model.dart';
import 'package:untitled/shared/models/search_model.dart';

import '../../../shared/errors/failure.dart';
import '../../../shared/functions/custom_snack_bar.dart';
import '../../../shared/models/governorate_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/services/constants/get_governorates_regions_service.dart';
import '../../../shared/network/remote/services/constants/get_governorates_service.dart';

class SearchCubit extends Cubit<Search_States> {
  SearchCubit() : super(Initial_SearchStates());
  static SearchCubit get(context) => BlocProvider.of(context);
  search_model? Search_model;
  List<PropertyModel> properties = [];
  final formKey = GlobalKey<FormState>();

  double? x, y;
  int? price, space;
  List<dynamic> prop = [];
  // void searchprice(RangeValues num) {
  //   values_p = num;
  //   emit(addprice());
  // }

  // void searchspace(RangeValues num) {
  //   values_s = num;
  //   emit(addspace());
  // }

  List<GovernorateModel> governorates = [];
  List<RegionModel> regions = [];
  GovernorateModel? selctedGovernorate;
  RegionModel? selectedRegion;
  bool governoratesLoading = false;
  bool regionsLoading = false;

  Future<void> getGovernorates() async {
    emit(itemloading());
    governoratesLoading = true;
    (await GetGovernoratesService.getGovernorates()).fold(
      (failure) {
        emit(SearchFailure(errorMessage: failure.errorMessege));
      },
      (governorates) {
        this.governorates = governorates;
        governoratesLoading = false;
        emit(Initial_SearchStates());
      },
    );
  }

  Future<void> getGovernorateRegions(BuildContext context) async {
    if (selctedGovernorate != null) {
      emit(itemloading());
      regionsLoading = true;
      (await GetGovernoratesRegionsService.getGovernoratesRegions(
              governorateID: selctedGovernorate!.id))
          .fold(
        (failure) {
          emit(SearchFailure(errorMessage: failure.errorMessege));
        },
        (regions) {
          this.regions.clear();
          this.regions = regions;
          regionsLoading = false;
          emit(Initial_SearchStates());
        },
      );
    } else {
      CustomeSnackBar.showSnackBar(
        context,
        msg: 'Please Select Governorate First',
        color: Colors.red,
      );
    }
  }

  void selectGovernorate({required int index}) {
    if (governorates.isNotEmpty) {
      emit(Initial_SearchStates());
      selctedGovernorate = governorates[index];
      emit(addcovernorates());
    }
  }

  void selectRegion({required int index}) {
    if (regions.isNotEmpty) {
      emit(Initial_SearchStates());
      selectedRegion = regions[index];
      emit(addregion());
    }
  }

  void removeSelectedItem({required String helper}) {
    emit(Initial_SearchStates());
    if (helper == 'G') {
      selctedGovernorate = null;
    } else {
      selectedRegion = null;
    }
    emit(addcovernorates());
  }

  Future<void> search() async {
    emit(SearchLoading());

    search_model(
        price: price!,
        space: space!,
        regionId: selectedRegion!.id,
        governorateId: selctedGovernorate!.id);

    (await getsearch(
      searchModel: Search_model!,
    ))
        .fold(
      (failure) {
        emit(SearchFailure(errorMessage: failure.errorMessege));
      },
      (success) {
        emit(Searchsuccess(properties: properties));
      },
    );
  }

  void changeIsFoveate({required PropertyModel properties}) {
    emit(Initial_SearchStates());
    properties.isFoveate = !properties.isFoveate;
    emit(ChangeIsFoveateSuccessg(isFoveate: properties.isFoveate));
  }

  Future<Either<Failure, void>> getsearch({
    required search_model searchModel,
  }) async {
    try {
      var response = await DioHelper.getData(
        url: 'properties/search',
        query: {
          'price': searchModel.price.toString(),
          'space': searchModel.space.toString(),
          'region_id': searchModel.regionId.toString(),
          'governorateId': searchModel.governorateId.toString(),
        },
        token: await CacheHelper.getData(key: 'Token'),
      );
      log(response.toString());
      List<PropertyModel> properties = [];
      for (var item in response.data['properties']) {
        properties.add(PropertyModel.fromJson(item));
        print(properties.length);
      }
      return right(null);
    } catch (ex) {
      log('\nException: there is an error in search method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
