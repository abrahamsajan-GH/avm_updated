import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:friend_private/backend/preferences.dart';
import 'package:friend_private/core/assets/app_images.dart';
import 'package:friend_private/core/constants/constants.dart';
import 'package:friend_private/core/theme/app_colors.dart';
import 'package:friend_private/pages/home/custom_scaffold.dart';
import 'package:friend_private/pages/home/page.dart';
import 'package:friend_private/src/common_widget/elevated_button.dart';

class FinalizePage extends StatelessWidget {
  final VoidCallback goNext;
  const FinalizePage({super.key, required this.goNext});
  static const String name = 'finalizePage';
  static const String routeName = '/finalizePage';
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.appLogo,
                height: 30.h,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'You are all set 🎉',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w500, height: 1.2),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: br30),
                height: 55.h,
                width: double.maxFinite,
                child: CustomElevatedButton(
                  backgroundColor: AppColors.white,
                  onPressed: () async {
                    if (SharedPreferencesUtil().onboardingCompleted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePageWrapper(),
                        ),
                      );
                    }
                  },
                  child: const Text('Get Started',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
