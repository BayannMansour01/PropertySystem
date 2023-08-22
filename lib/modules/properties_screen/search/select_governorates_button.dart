import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/properties_screen/search/search_cubit.dart';
import '../../../shared/functions/custom_dialog.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/widgets/custome_dialog_button.dart';
import '../../../shared/widgets/custome_progress_indicator.dart';
import '../../../shared/widgets/custome_text_field.dart';
//import '../cubit/add_property_cubit.dart';

class SelectGovernoratesButtons extends StatelessWidget {
  final SearchCubit searchCubit;
  const SelectGovernoratesButtons({super.key, required this.searchCubit});

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
          hintText: searchCubit.selctedGovernorate == null
              ? 'Governorate...'
              : searchCubit.selctedGovernorate!.name,
          hintStyle: const TextStyle(fontSize: 17, color: Colors.white),
          iconData: Icons.place,
          disableFocusNode: true,
          suffixIcon: searchCubit.governoratesLoading
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
              : searchCubit.selctedGovernorate == null
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
            if (searchCubit.selctedGovernorate != null) {
              searchCubit.removeSelectedItem(helper: 'G');
            } else {
              await searchCubit.getGovernorates();
              // ignore: use_build_context_synchronously
              CustomDialog.showCustomDialog(
                context,
                children: List.generate(
                  searchCubit.governorates.length,
                  (index) {
                    return CustomDialogButton(
                      onTap: () {
                        searchCubit.selectGovernorate(index: index);
                        Navigator.pop(context);
                        log(searchCubit.selctedGovernorate?.name ?? '');
                      },
                      text: searchCubit.governorates[index].name,
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
