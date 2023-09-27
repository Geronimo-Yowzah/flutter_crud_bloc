import 'package:crud/src/posts/bloc/getPost/posts_bloc.dart';
import 'package:crud/src/posts/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.title, required this.data});

  final String title;
  final PostsModel data;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize TextEditingController values with widget.data values
    idController.text = widget.data.id.toString();
    userIdController.text = widget.data.userId.toString();
    titleController.text = widget.data.title;
    bodyController.text = widget.data.body;
  }

  void savePut() {
    final id = idController.text;
    final userId = userIdController.text;
    final title = titleController.text;
    final body = bodyController.text;

    // Dispatch a PostAddEvent to the PostBloc with the input data
    context.read<PostsBloc>().add(PostUpdateDataEvent(
          id: id,
          userId: userId,
          title: title,
          body: body,
        ));
    context.go('/'); // Close the current page
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
                savePut();
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
              child: TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userIdController,
                decoration: const InputDecoration(
                  labelText: 'UserID',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
