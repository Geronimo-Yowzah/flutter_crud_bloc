import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(event, Emitter<PostsState> emit) async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.https('https://jsonplaceholder.typicode.com/posts'));
      print(response.body);
    } catch (e) {
      log(e.toString() as num);
    }
  }
}
