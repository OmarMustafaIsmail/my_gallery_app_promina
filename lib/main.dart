import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_gallery_app_promina/modules/home/cubit/cubit.dart';
import 'package:my_gallery_app_promina/modules/home/home_screen.dart';
import 'package:my_gallery_app_promina/modules/login/login_screen.dart';
import 'package:my_gallery_app_promina/shared/bloc_observer.dart';
import 'package:my_gallery_app_promina/shared/network/local/local.dart';
import 'package:my_gallery_app_promina/shared/network/remote/dio_helper.dart';
import 'package:sizer/sizer.dart';

import 'modules/login/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget initialWidget;
  var token = CacheHelper.getData(key: "token");
  if(token !=null){
    initialWidget= const HomeScreen();
  }
  else{
    initialWidget = LoginScreen();
  }
  runApp( MyApp(initialWidget: initialWidget,));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.initialWidget,super.key});
  final Widget initialWidget;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => LoginCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => HomeScreenCubit()..onInit(context),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Segoe',
            primarySwatch: Colors.blue,
          ),
          home: initialWidget,
          builder: EasyLoading.init(),
        ),
      );
    });
  }
}
