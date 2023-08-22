import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:untitled/modules/properties_screen/search/search_cubit.dart';
import '../../../shared/functions/custom_dialog.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custome_dialog_button.dart';
import '../../../shared/widgets/custome_progress_indicator.dart';
import '../../../shared/widgets/custome_text_field.dart';

class SelectRegionsButtons extends StatelessWidget {
  final SearchCubit searchCubit;
  const SelectRegionsButtons({super.key, required this.searchCubit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160.w,
          height: 55.h,
          decoration: BoxDecoration(
            color: AppColors.color2,
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        CustomeTextField(
          width: 160.w,
          noOutlineBorder: true,
          outLineBorderColor: Colors.transparent,
          hintText: searchCubit.selectedRegion == null
              ? 'Region...'
              : searchCubit.selectedRegion!.name,
          hintStyle: const TextStyle(fontSize: 17, color: Colors.white),
          iconData: Icons.add_location_rounded,
          disableFocusNode: true,
          suffixIcon: searchCubit.regionsLoading
              ? SizedBox(
                  width: 5,
                  child: Transform.scale(
                    scale: .5,
                    child: const CustomeProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                )
              : searchCubit.selectedRegion == null
                  ? const Icon(
                      Icons.expand_more_sharp,
                      size: 40,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.playlist_remove_sharp,
                      size: 30,
                      color: Colors.white,
                    ),
          onTap: () async {
            if (searchCubit.selectedRegion != null) {
              searchCubit.removeSelectedItem(helper: 'R');
            } else {
              await searchCubit.getGovernorateRegions(context);
              if (searchCubit.selctedGovernorate != null) {
                // ignore: use_build_context_synchronously
                CustomDialog.showCustomDialog(
                  context,
                  children: List.generate(
                    searchCubit.regions.length,
                    (index) {
                      return CustomDialogButton(
                        onTap: () {
                          searchCubit.selectRegion(index: index);
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => GoogleMapViews(
                          //       select: true,
                          //       locations: const [],
                          //       lat: searchCubit.regions[index].x,
                          //       lon: searchCubit.regions[index].y,
                          //       searchCubit: searchCubit,
                          //     ),
                          //  ),
                          //    );
                          Navigator.pop(context);
                          log(searchCubit.selectedRegion?.name ?? '');
                        },
                        text: searchCubit.regions[index].name,
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
