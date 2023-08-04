import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/styles/app_colors.dart';
import '../../../shared/styles/text_styles.dart';

class LoginDesignSection extends StatelessWidget {
  const LoginDesignSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Center(
        //   child: CustomeImage(
        //     image: AppAssets.loginImage,
        //     width: 220.w,
        //     height: 150.h,
        //   ),
        // ),
        SizedBox(
          width: 220.w,
          height: 150.h,
        ),
        SizedBox(height: 40.h),
        Text(
          'Login',
          style: Styles.textStyle50.copyWith(color: AppColors.defaultColor),
        ),
        SizedBox(height: 10.h),
        Text(
          'Please Enter Your Credentials To Get Started ...',
          style: Styles.textStyle18,
          maxLines: 2,
        ),
      ],
    );
  }
}
