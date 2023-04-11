import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery_app_promina/models/user_model.dart';
import 'package:my_gallery_app_promina/modules/home/home_screen.dart';
import 'package:my_gallery_app_promina/modules/login/cubit/states.dart';
import 'package:my_gallery_app_promina/shared/components.dart';
import 'package:my_gallery_app_promina/shared/network/local/local.dart';
import 'package:my_gallery_app_promina/shared/network/remote/dio_helper.dart';
import 'package:my_gallery_app_promina/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginScreenStates> {
  LoginCubit() : super(LoginScreenInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
}
  LoginModel? loginModel;
  loginUser({required String email, required String password,required BuildContext context}) async {
    emit(LoginLoadingState());

    await DioHelper.postData(
        url: login, data: {'email': email, 'password': password}).then((value) {
          if(value.data['user'] == null){
            print(value.data["error_message"]);
            showToast(text: "invalid user credentials", state: ToastStates.ERROR);
            emit(LoginErrorState());
          }
          else{
            loginModel = LoginModel.fromJson(value.data);
            CacheHelper.saveData(key: "token", value: loginModel!.token);
            CacheHelper.saveData(key: "email", value: loginModel!.user!.email);
            CacheHelper.saveData(key: "name", value: loginModel!.user!.name);
            navigateAndFinish(context, HomeScreen());
            emit(LoginSuccessState());
          }

    }).catchError((error) {
      showToast(text: "invalid user credentials", state: ToastStates.ERROR);
      emit(LoginErrorState());
    });
  }
}
