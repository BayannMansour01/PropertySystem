import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/properties_screen/search/search_cubit.dart';
import 'package:untitled/modules/properties_screen/search/search_state.dart';
import 'package:untitled/modules/properties_screen/widgets/header.dart';

import '../../../shared/functions/custom_snack_bar.dart';
import '../../../shared/models/property_model.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custome_progress_indicator.dart';
import '../../property_details_screen/property_details_screen.dart';
import '../widgets/custom_property_card.dart';
import '../widgets/footer.dart';
import '../widgets/row_details.dart';

class searchView extends StatelessWidget {
  const searchView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit()..search(),
        child: BlocConsumer<SearchCubit, Search_States>(
            listener: (context, state) {},
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                        backgroundColor: AppColors.defaultColor,
                        title: const Text('PropScan'),
                        centerTitle: true,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: const AssetImage(
                                'assets/images/a8.png',
                              ),
                              height: 50.h,
                            ),
                          )
                        ]),
                    body: const SearchViewBody()),
              );
            }));
  }
}

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, Search_States>(
      listener: (context, state) {
        if (state is SearchFailure) {
          CustomeSnackBar.showErrorSnackBar(
            context,
            msg: state.errorMessage,
          );
        }
        if (state is ChangeIsFoveateSuccessg) {
          CustomeSnackBar.showSnackBar(
            context,
            msg: state.isFoveate == true
                ? 'Add to Foveate'
                : 'Delete from Foveate',
            color: state.isFoveate == true
                ? Color.fromARGB(255, 104, 136, 105)
                : Colors.red,
            duration: const Duration(
              milliseconds: 300,
            ),
          );
        }
        // if (state is GetPropertyChatUserSuccess) {
        //   Navigator.push(context, MaterialPageRoute(
        //     builder: (context) {
        //       return ChatView(user: state.chatUser);
        //     },
        //   ));
        // } else if (state is PropertiesFailure) {
        //   CustomeSnackBar.showSnackBar(
        //     context,
        //     msg: 'Something Went Wrong, Please Try Again',
        //     color: Colors.red,
        //   );
        // }
      },
      builder: (context, state) {
        if (state is Searchsuccess) {
          BlocProvider.of<SearchCubit>(context).prop = state.properties;
        } else if (state is SearchFailure) {
          return Center(
            child: SizedBox(
              width: 300.w,
              height: 150.h,
              child: Card(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Center(
                        child: Text(
                      'Network error',
                      style: TextStyle(fontSize: 30),
                    )),
                    const Center(
                        child: Text(
                      'Click to retry',
                      style: TextStyle(fontSize: 20),
                    )),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<SearchCubit>(context).search();
                      },
                      child: const Icon(
                        Icons.refresh_rounded,
                        size: 60,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is SearchLoading) {
          return const CustomeProgressIndicator();
        }
        return RefreshIndicator(
          onRefresh: () {
            Future<void> ref() async {
              BlocProvider.of<SearchCubit>(context).search();
            }

            return ref();
          },
          child: ReorderableListView.builder(
            header: const Header(),
            itemBuilder: (context, index) {
              PropertyModel property =
                  BlocProvider.of<SearchCubit>(context).prop[index];

              return PropertyCardg(
                index: index,
                searchCubit: BlocProvider.of<SearchCubit>(context),
                properties: property,
                myProperties: false,
                key: Key(index.toString()),
              );
            },
            itemCount: BlocProvider.of<SearchCubit>(context).prop.length,
            footer: const Footer(),
            padding: const EdgeInsets.all(16.0),
            onReorder: (int oldIndex, int newIndex) {
              log(oldIndex.toString());
              log(newIndex.toString());
            },
          ),
        );
      },
    );
  }
}

class PropertyCardg extends StatelessWidget {
  final int index;
  final SearchCubit searchCubit;
  final PropertyModel properties;
  final bool myProperties;

  const PropertyCardg({
    super.key,
    required this.index,
    required this.searchCubit,
    required this.properties,
    required this.myProperties,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(context, PropertyDetailsView.route, arguments: {
          "propertyID": properties.id,
        });
        log(properties.id.toString());

        // propertiesCubit.getDailyRentDates();

        // CustomDialog.showDailyRentDialog(
        //   context,
        //   propertiesCubit: propertiesCubit,
        //   dailyRentGrid: DailyRentGrid(propertiesCubit: propertiesCubit),
        // );

        // log(propertiesCubit.nearestProps.length.toString());
        // log(propertiesCubit.nearestProps[1].x.toString());
        // log(propertiesCubit.nearestProps[1].y.toString());

        // propertiesCubit.getDailyRentDates();

        // CustomDialog.showDailyRentDialog(
        //   context,
        //   propertiesCubit: propertiesCubit,
        //   dailyRentGrid: DailyRentGrid(propertiesCubit: propertiesCubit),
        // );

        // propertiesCubit.getDailyRentDates();

        // CustomDialog.showDailyRentDialog(
        //   context,
        //   propertiesCubit: propertiesCubit,
        //   dailyRentGrid: DailyRentGrid(propertiesCubit: propertiesCubit),
        // );
      },
      child: Card(
        key: key,
        elevation: 8,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                    image: DecorationImage(
                      // image: AssetImage(AppAssets.logo),
                      image: NetworkImage(
                        properties.images.isEmpty
                            ? ''
                            : "http://192.168.43.142:8000/${properties.images[0]["image"]}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (!myProperties)
                  Positioned(
                    right: 10.w,
                    top: 5.h,
                    child: TextButton(
                      onPressed: () {
                        searchCubit.changeIsFoveate(properties: properties);
                        log('${properties.isFoveate}');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: Colors.grey[50],
                        ),
                        child: Center(
                          child: Icon(
                            properties.isFoveate == true
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const RowDetails(
              icon: Icons.phone,
              text: '0934487928',
            ),
            RowDetails(
              icon: Icons.location_on_outlined,
              text: "${properties.governorate}-${properties.region}",
            ),
          ],
        ),
      ),
    );
  }
}
