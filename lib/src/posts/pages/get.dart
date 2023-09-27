import 'package:crud/src/posts/bloc/getPost/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GetPage extends StatefulWidget {
  const GetPage({super.key, required this.title});

  final String title;

  @override
  State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    context.read<PostsBloc>().add(PostsInitialFetchEvent());
    super.initState();
  }

  void saveDelete(String id) {
    context.read<PostsBloc>().add(PostDeleteDataEvent(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  context.read<PostsBloc>().add(PostsResetFetchEvent()),
              icon: const Icon(Icons.lock_reset)),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Get Page'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green.shade300,
            child: const Icon(Icons.add),
            onPressed: () =>
                // Navigator.pushNamed(context, AppRoute.post)
                context.go('/post'),
          ),
        ],
      ),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SuccessState) {
          final successState = state.posts;
          if (successState == null) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: successState.length,
              itemBuilder: (context, index) {
                final data = successState[index];
                return Card(
                  color: Colors.grey.shade100,
                  margin: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text('Id: ${data.id}, Title: ${data.title}'),
                    titleTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: Text('Body ${data.body}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => context.go('/edit', extra: data)
                            // Navigator.pushNamed(
                            // context, AppRoute.edit,
                            // arguments: data),
                            ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            saveDelete(data.id.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return Container();
        }
      }),
    );
  }
}
