import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gallery_app_promina/modules/login/cubit/cubit.dart';
import 'package:my_gallery_app_promina/modules/login/cubit/states.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginScreenStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/back.png"),
                    fit: BoxFit.cover),
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: SvgPicture.asset(
                            "assets/icons/camera.svg",
                            height: 15.h,
                          ),
                        )),
                    Center(
                      child: Text(
                        "My",
                        style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Center(
                      child: Text("GALLERY",
                          style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white.withOpacity(0.4)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "LOG IN",
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.h),
                                      child: TextFormField(
                                        validator: (String? s) {
                                          if (!cubit.isValidEmail(s!) ||
                                              s.isEmpty) {
                                            return "please enter a valid email";
                                          }
                                        },
                                        controller: userNameTextController,
                                        scrollPadding:
                                            EdgeInsets.only(bottom: 40.h),
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 1.2.h,
                                                    horizontal: 5.w),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500]),
                                            hintText: "Email",
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 4.h),
                                      child: TextFormField(
                                        validator: (String? s) {
                                          if (s!.isEmpty) {
                                            return "please enter your password";
                                          }
                                        },
                                        controller: passwordTextController,
                                        scrollPadding:
                                            EdgeInsets.only(bottom: 40.h),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 1.2.h,
                                                    horizontal: 5.w),
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500]),
                                            hintText: "Password",
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 1.h),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.lightBlue[300],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 0),
                                        onPressed: () {
                                          _formKey.currentState!.save();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            cubit.loginUser(
                                                email:
                                                    userNameTextController.text,
                                                password:
                                                    passwordTextController.text,
                                                context: context);
                                          }
                                        },
                                        child: Center(
                                            child: state is LoginLoadingState
                                                ? const SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.grey,
                                                      strokeWidth: 2,
                                                    ),
                                                  )
                                                : const Text(
                                                    "SUBMIT",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
