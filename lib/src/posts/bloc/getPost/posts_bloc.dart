import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crud/src/posts/model/posts_model.dart';
import 'package:crud/src/posts/repos/posts_repos.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(LoadingState()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);

    on<PostsResetFetchEvent>(postsResetFetchEvent);

    on<PostAddDataEvent>(postAddDataEvent);

    on<PostUpdateDataEvent>(postUpdateDataEvent);

    on<PostDeleteDataEvent>(postDeleteDataEvent);
  }

  postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    List<PostsModel> posts;

    if(state.posts == null){
      posts = await PostsRepo.fetchPosts();
      if (posts != null) {
        emit(SuccessState(posts));
      }
    }else{
      posts = state.posts!;
      emit(SuccessState(posts));
    }
  }

  postsResetFetchEvent(
      PostsResetFetchEvent event, Emitter<PostsState> emit) async {
    List<PostsModel> posts = await PostsRepo.fetchPosts();

    if (posts != null) {
      emit(SuccessState(posts));
    }

  }

  postAddDataEvent(PostAddDataEvent event, Emitter<PostsState> emit) async {
    final List<PostsModel>? updatedPosts = state.posts;
    var Id = 0;

    PostsModel post = await PostsRepo.addPosts(
        userId: event.userId, title: event.title, body: event.body);

    updatedPosts?.forEach((updatedPosts) {
      if (updatedPosts.id > Id) {
        Id = updatedPosts.id;
      }
    });

    if (post != null) {
      if (post.id == 101) {
        post.id = Id + 1;
      }
      final List<PostsModel> posts = [];
      posts.add(post);

      for (int i = 0; i < updatedPosts!.length; i++) {
        posts.add(updatedPosts[i]);
      }

      emit(SuccessState(posts));
    }
  }

  postUpdateDataEvent(
      PostUpdateDataEvent event, Emitter<PostsState> emit) async {
    final List<PostsModel>? updatedPosts = state.posts;

    PostsModel post = await PostsRepo.updatePosts(
        id: event.id,
        userId: event.userId,
        title: event.title,
        body: event.body);

    if (post != null) {
      final List<PostsModel> posts = [];
      posts.add(post);

      for (int i = 0; i < updatedPosts!.length; i++) {
        if (updatedPosts[i].id != post.id) {
          posts.add(updatedPosts[i]);
        }
      }

      emit(SuccessState(posts));
    }
  }

  postDeleteDataEvent(
      PostDeleteDataEvent event, Emitter<PostsState> emit) async {
    var Id = 0;
    final List<PostsModel>? updatedPosts = state.posts;

    int ID = await PostsRepo.deletePosts(id: event.id);
    updatedPosts?.forEach((updatedPosts) {
      if (updatedPosts.id > Id) {
        Id = updatedPosts.id;
      }
    });

    final List<PostsModel> posts = [];
    for (int i = 0; i < updatedPosts!.length; i++) {
      if (updatedPosts[i].id != ID) {
        posts.add(updatedPosts[i]);
      }
    }

    emit(SuccessState(posts));
  }
}
