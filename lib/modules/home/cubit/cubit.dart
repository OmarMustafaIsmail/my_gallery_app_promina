import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery_app_promina/modules/home/cubit/states.dart';
import 'package:my_gallery_app_promina/modules/login/login_screen.dart';
import 'package:my_gallery_app_promina/shared/components.dart';

import '../../../shared/network/local/local.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  String user = "";
  List<String> images = [];

  onInit(context) async {
    emit(HomeScreenGettingDataLoadingState());
    images.clear();
    var fullName = CacheHelper.getData(key: "name");
    List<String> names = fullName.split(" ");
    user = names[0];
    await DioHelper.getData(
      url: userGallery,
      token: galleryToken,
    ).then((value) {
      value.data["data"]["images"].forEach((element) => images.add(element));
      emit(HomeScreenGettingDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeScreenGettingDataErrorState());
    });
  }

  logOut(context) {
    CacheHelper.removeData(key: "token");
    CacheHelper.removeData(key: "name");
    CacheHelper.removeData(key: "email");
    navigateAndFinish(context, LoginScreen());
  }

  XFile? imageFile;

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      imageFile = imageTemp;
      uploadImage();
    } on PlatformException catch (error) {
      showToast(text: "Failed to pick image", state: ToastStates.ERROR);
    }
  }

  uploadImage() async {
    if (imageFile == null) return;
    emit(HomeScreenUploadImageLoadingState());
    EasyLoading.show(status: "Uploading..", dismissOnTap: false);
    FormData formData = FormData.fromMap({
      'img': await MultipartFile.fromFile(imageFile!.path,
          filename: imageFile!.name)
    });
    await DioHelper.postData(url: upload, data: formData, token: galleryToken)
        .then((value) {
      print(value.data);
      EasyLoading.showSuccess("Image Uploaded");
      emit(HomeScreenUploadImageSuccessState());
    }).catchError((error) {
      EasyLoading.showError("Error uploading image");
      emit(HomeScreenUploadImageErrorState());
      print(error.toString());
    });
  }
}
