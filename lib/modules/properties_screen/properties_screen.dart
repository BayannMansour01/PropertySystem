import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:untitled/modules/google_map_screen/google_map_screen.dart';

import 'package:carousel_slider/carousel_slider.dart';
//import 'package:untitled/modules/add_property_screen/widgets/select_regions_button.dart';

import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_states.dart';
import 'package:untitled/modules/properties_screen/search/searchVeiw.dart';
import 'package:untitled/modules/properties_screen/search/search_cubit.dart';
import 'package:untitled/modules/properties_screen/search/search_state.dart';
import 'package:untitled/modules/properties_screen/search/select_governorates_button.dart';
import 'package:untitled/modules/properties_screen/search/select_regions_button.dart';
import 'package:untitled/modules/properties_screen/widgets/custom_drawer.dart';
import 'package:untitled/modules/properties_screen/widgets/custom_property_card.dart';
import 'package:untitled/modules/properties_screen/widgets/footer.dart';
import 'package:untitled/modules/properties_screen/widgets/header.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
import 'package:untitled/shared/models/property_model.dart';
import 'package:untitled/shared/models/user_model.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';

import 'package:untitled/shared/widgets/custome_progress_indicator.dart';
import '../../shared/models/property_model.dart';

import '../../shared/functions/custom_snack_bar.dart';

import '../../shared/styles/app_colors.dart';
import '../add_property_screen/widgets/property_text_field.dart';

class PropertiesView extends StatefulWidget {
  static const route = 'PropertiesView';
  final UserModel? userModel;
  const PropertiesView({super.key, this.userModel});

  @override
  State<PropertiesView> createState() => _PropertiesViewState();
}

class _PropertiesViewState extends State<PropertiesView> {
  @override
  void initState() {
    super.initState();
    FirebaseAPIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertiesCubit()
        ..getAllProperties()
        ..getNearestProperties(),
      child: BlocBuilder<PropertiesCubit, PropertiesStates>(
        builder: (context, state) {
          PropertiesCubit propertiesCubit =
              BlocProvider.of<PropertiesCubit>(context);
          return Scaffold(
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
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          //    isScrollControlled: true,

                          builder: (context) => BlocProvider(
                                create: (context) => SearchCubit(),
                                child: BlocConsumer<SearchCubit, Search_States>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    SearchCubit searchcubit =
                                        BlocProvider.of<SearchCubit>(context);
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SelectGovernoratesButtons(
                                              searchCubit: searchcubit,
                                            ),
                                            Divider(
                                                color: Colors.grey,
                                                height: 20.h),
                                            SelectRegionsButtons(
                                                searchCubit: searchcubit),
                                            Divider(
                                                color: Colors.grey,
                                                height: 20.h),
                                            PropertyInfoItem(
                                              text: 'Space',
                                              onChanged: (p0) => searchcubit
                                                  .space = int.parse(p0),
                                            ),
                                            Divider(
                                                color: Colors.grey,
                                                height: 20.h),
                                            PropertyInfoItem(
                                              text: 'Price',
                                              onChanged: (p0) => searchcubit
                                                  .price = int.parse(p0),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Wrap(children: <Widget>[
                                              Row(children: [
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          height: 3.0,
                                                          width: 90.0,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextButton(
                                                          child: const Text(
                                                            'Search',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .defaultColor,
                                                                fontSize: 25),
                                                          ),
                                                          onPressed: () async {
                                                            // if (searchcubit
                                                            //     .formKey
                                                            //     .currentState!
                                                            //     .validate()) {
                                                            if (searchcubit
                                                                    .selectedRegion ==
                                                                null) {
                                                              CustomeSnackBar
                                                                  .showSnackBar(
                                                                context,
                                                                msg:
                                                                    'Please Select Region',
                                                                color:
                                                                    Colors.red,
                                                              );
                                                            } else if (searchcubit
                                                                    .price ==
                                                                null) {
                                                              CustomeSnackBar
                                                                  .showSnackBar(
                                                                context,
                                                                msg:
                                                                    'Please Select price',
                                                                color:
                                                                    Colors.red,
                                                              );
                                                            } else if (searchcubit
                                                                    .space ==
                                                                null) {
                                                              CustomeSnackBar
                                                                  .showSnackBar(
                                                                context,
                                                                msg:
                                                                    'Please Select space',
                                                                color:
                                                                    Colors.red,
                                                              );
                                                            } else {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const searchView()));
                                                            }
                                                            //  }
                                                          }),
                                                    ]),
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                          height: 3.0,
                                                          width: 90.0,
                                                          color: Colors.grey),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .defaultColor,
                                                              fontSize: 25),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ]),
                                              ]),
                                            ])
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ));
                    },
                    icon: Icon(Icons.search))
              ],
            ),

            bottomNavigationBar: BottomNavigationBar(
              items: propertiesCubit.bottomNavigationBarItems,
              onTap: (index) {
                propertiesCubit.changeBottomNavigationBarIndex(index);
              },
              currentIndex: propertiesCubit.bottomNavigationBarIndex,
            ),
            drawer: widget.userModel != null
                ? CustomDrawer.getCustomDrawer(
                    context,
                    propertiesCubit: propertiesCubit,
                    scaffoldKey: propertiesCubit.scaffoldKey,
                    userModel: widget.userModel!,
                  )
                : null,
            body: propertiesCubit.bottomNavigationBarIndex == 0
                ? const PropertiesViewBody()
                : GoogleMapViewBody(
                    select: false,
                    locations: propertiesCubit.nearestProps,
                  ),
            //  propertiesCubit
            //     .widgets[propertiesCubit.bottomNavigationBarIndex],
          );
        },
      ),
    );
  }
}

class PropertiesViewBody extends StatelessWidget {
  const PropertiesViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertiesCubit, PropertiesStates>(
      listener: (context, state) {
        if (state is PropertiesFailure) {
          CustomeSnackBar.showErrorSnackBar(
            context,
            msg: state.errorMessage,
          );
        }
        if (state is ChangeIsFoveateSuccess) {
          CustomeSnackBar.showSnackBar(
            context,
            msg: state.isFoveate == true
                ? 'Add to Foveate'
                : 'Delete from Foveate',
            color: state.isFoveate == true ? Colors.green : Colors.red,
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
        if (state is PropertiesSuccess) {
          BlocProvider.of<PropertiesCubit>(context).properties =
              state.properties;
        } else if (state is PropertiesFailure) {
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
                        BlocProvider.of<PropertiesCubit>(context)
                            .getAllProperties();
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
        } else if (state is PropertiesLoading) {
          return const CustomeProgressIndicator();
        }
        return RefreshIndicator(
          onRefresh: () {
            Future<void> ref() async {
              BlocProvider.of<PropertiesCubit>(context).getAllProperties();
              BlocProvider.of<PropertiesCubit>(context).getNearestProperties();
            }

            return ref();
          },
          child: ReorderableListView.builder(
            header: const Header(),
            itemBuilder: (context, index) {
              PropertyModel property =
                  BlocProvider.of<PropertiesCubit>(context).properties[index];

              return PropertyCard(
                index: index,
                propertiesCubit: BlocProvider.of<PropertiesCubit>(context),
                properties: property,
                myProperties: false,
                key: Key(index.toString()),
              );
            },
            itemCount:
                BlocProvider.of<PropertiesCubit>(context).properties.length,
            // scrollDirection: Axis.horizontal,
            // reverse: true,
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
