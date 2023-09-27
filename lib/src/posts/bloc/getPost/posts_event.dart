part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent extends Equatable{
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostsInitialFetchEvent extends PostsEvent{}

class PostsResetFetchEvent extends PostsEvent{}

class PostAddDataEvent extends PostsEvent {
  final String userId;
  final String title;
  final String body;

  const PostAddDataEvent({
    required this.userId,
    required this.title,
    required this.body,
  });
}

class PostUpdateDataEvent extends PostsEvent {
  final String id;
  final String userId;
  final String title;
  final String body;

  const PostUpdateDataEvent({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });
}

class PostDeleteDataEvent extends PostsEvent {
  final String id;

  const PostDeleteDataEvent({
    required this.id,
  });
}