import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crud/src/posts/model/posts_model.dart';
import 'package:crud/src/posts/repos/posts_repos.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState(posts: [])){}
}
