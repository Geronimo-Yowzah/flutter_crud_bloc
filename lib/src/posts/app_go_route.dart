import 'package:crud/src/posts/model/posts_model.dart';
import 'package:crud/src/posts/pages/edit.dart';
import 'package:crud/src/posts/pages/get.dart';
import 'package:crud/src/posts/pages/post.dart';
import 'package:go_router/go_router.dart';

class AppGoRoute {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'getPage',
        path: '/',
        builder: (context, state) => const GetPage(title: 'Get Page'),
      ),
      GoRoute(
        name: 'postPage',
        path: '/post',
        builder: (context, state) => const PostPage(title: 'Post Page'),
      ),
      GoRoute(
        name: 'editPage',
        path: '/edit',
        builder: (context, state) {
          PostsModel data = state.extra as PostsModel;
          return EditPage(title: 'Edit Page', data: data);
        },
      ),
    ],
  );
}
