part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<PostsModel> posts;

  const PostState({required this.posts});

  // PostState copyWith(List<PostsModel> posts){
  //   return PostState(posts: posts ?? this.posts);
  // }

  @override
  List<Object?> get props => [posts];
}

// class PostInitial extends PostState {}
//
// abstract class PostsActionState extends PostState {}
//
// class PostAdditionSuccessState extends PostsActionState{}
//
// class PostAdditionErrorState extends PostsActionState{}
//
// class PostFetchingSuccessfulState extends PostState {
//   final List<PostsModel> posts;
//   PostFetchingSuccessfulState({
//     required this.posts,
//   });
// }

