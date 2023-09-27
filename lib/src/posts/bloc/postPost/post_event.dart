part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostInitialFetchEvent extends PostEvent{}

class PostAddEvent extends PostEvent {
  final String userId;
  final String id;
  final String title;
  final String body;

  PostAddEvent({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}
