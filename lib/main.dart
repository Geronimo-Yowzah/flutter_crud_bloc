import 'package:crud/src/posts/app_go_route.dart';
import 'package:crud/src/posts/app_route.dart';
import 'package:crud/src/posts/bloc/app_bloc_observer.dart';
import 'package:crud/src/posts/bloc/edit/edit_bloc.dart';
import 'package:crud/src/posts/bloc/getPost/posts_bloc.dart';
import 'package:crud/src/posts/bloc/postPost/post_bloc.dart';
import 'package:crud/src/posts/pages/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
  // BlocOverrides.runZoned(() {
  //   runApp(MyApp());
  // }, blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appGoRoute = AppGoRoute();
    final getPage = BlocProvider<PostsBloc>(create: (context) => PostsBloc());
    final postPage = BlocProvider<PostBloc>(create: (context) => PostBloc());
    final editPage = BlocProvider<EditBloc>(create: (context) => EditBloc());

    return MultiBlocProvider(
      providers: [getPage, postPage, editPage],
      child: MaterialApp.router(
        title: 'Crud Bloc',
        routerConfig: appGoRoute.router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
          useMaterial3: true,
        ),
      ),
    );

    // return MultiBlocProvider(
    //   providers: [getPage, postPage, editPage],
    //   child: MaterialApp(
    //     title: 'Crud Bloc',
    //     routes: AppRoute().getAll,
    //     theme: ThemeData(
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
    //       useMaterial3: true,
    //     ),
    //     home: const GetPage(title: 'Posts Page'),
    //   ),
    // );
  }
}
