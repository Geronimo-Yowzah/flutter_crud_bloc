import 'package:crud/src/posts/app_route.dart';
import 'package:crud/src/posts/bloc/getPost/posts_bloc.dart';
import 'package:crud/src/posts/bloc/postPost/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.title});

  final String title;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final controllerUserId = TextEditingController();
  final controllerId = TextEditingController();
  final controllerTitle = TextEditingController();
  final controllerBody = TextEditingController();

  void savePost() {
    final userId = controllerUserId.text;
    final title = controllerTitle.text;
    final body = controllerBody.text;

    // Dispatch a PostAddEvent to the PostBloc with the input data
    context.read<PostsBloc>().add(PostAddDataEvent(
          userId: userId,
          title: title,
          body: body,
        ));
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => context.go('/'), icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {
                savePost();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerUserId,
                decoration: const InputDecoration(
                  labelText: 'userId',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerTitle,
                decoration: const InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerBody,
                decoration: const InputDecoration(
                  labelText: 'body',
                  border: OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
