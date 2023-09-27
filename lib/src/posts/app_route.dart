
import 'package:crud/src/posts/model/posts_model.dart';
import 'package:crud/src/posts/pages/edit.dart';
import 'package:crud/src/posts/pages/get.dart';
import 'package:crud/src/posts/pages/post.dart';
import 'package:flutter/cupertino.dart';

class AppRoute {
  static const home = "home";
  static const post = "post";
  static const edit = "edit";
  final _route = <String, WidgetBuilder>{
    home: (context) => const GetPage(title: "Get Page"),
    post: (context) => const PostPage(title: "Post Page"),
    edit: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as PostsModel; // Retrieve the argument (data)
      return EditPage(title: "Edit Page", data: args,);
    },
  };

  get getAll => _route;
}