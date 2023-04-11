import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery_app_promina/modules/home/components/custom_button.dart';
import 'package:my_gallery_app_promina/modules/home/cubit/cubit.dart';
import 'package:my_gallery_app_promina/modules/home/cubit/states.dart';
import 'package:my_gallery_app_promina/modules/login/login_screen.dart';
import 'package:my_gallery_app_promina/shared/network/local/local.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return RefreshIndicator(
          onRefresh: ()=>cubit.onInit(context),
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/back_g.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 1.h),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  Text(cubit.user,
                                      style: TextStyle(fontSize: 20.sp)),
                                ],
                              ),
                              const Spacer(),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    const AssetImage("assets/images/user.png"),
                                radius: 3.5.h,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                  "logout",
                                  SvgPicture.asset(
                                    "assets/icons/logout.svg",
                                    height: 2.5.h,
                                  ),
                                  () => cubit.logOut(context)),
                              CustomButton(
                                  "upload",
                                  SvgPicture.asset(
                                    "assets/icons/upload.svg",
                                    height: 2.5.h,
                                  ), () {
                                showDialog(
                                    context: context,
                                    builder: (context) => ClipRRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15)),
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.6),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 6.h, bottom: 3.h),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              239, 216, 249, 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 3.w,
                                                                vertical: 1.h),
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              cubit.pickImage(
                                                                  ImageSource
                                                                      .gallery),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/gallery.png",
                                                                height: 5.h,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Gallery",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                            .grey[
                                                                        700]),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 6.h),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              235, 246, 255, 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 3.w,
                                                                vertical: 1.h),
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              cubit.pickImage(
                                                                  ImageSource
                                                                      .camera),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/camera_2.png",
                                                                height: 5.h,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Camera",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                            .grey[
                                                                        700]),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                              }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 35.w,
                                            crossAxisSpacing: 2.w,
                                            mainAxisSpacing: 5.h,
                                            childAspectRatio: 1.0),
                                    itemCount: cubit.images.length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Container(
                                            height: 220,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: OptimizedCacheImage(
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Center(
                                                child: CircularProgressIndicator(
                                                  color: Colors.grey,
                                                  strokeWidth: 2,
                                                  value: progress.progress,
                                                ),
                                              ),
                                              imageUrl: cubit.images[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ));
                                    }),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
