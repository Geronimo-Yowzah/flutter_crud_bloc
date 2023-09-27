part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final List<PostsModel>? posts;


  const PostsState({this.posts});

  @override
  List<Object> get props => [posts!];

  @override
  String toString() {
    return posts.toString();
  }
}
class LoadingState extends PostsState{}

class SuccessState extends PostsState{
  const SuccessState(List<PostsModel>? posts): super(posts: posts);
}

// class InitPosts extends PostsState{
//   const InitPosts(List<PostsModel>? posts): super(posts: posts);
// }



