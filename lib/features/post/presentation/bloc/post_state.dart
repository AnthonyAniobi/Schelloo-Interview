part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  final List<PostListEntity> posts;
  const PostState(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostInitial extends PostState {
  PostInitial() : super([]);
}

class PostLoading extends PostState {
  const PostLoading(super.posts);
}

class PostLoaded extends PostState {
  const PostLoaded(super.posts);
}

class SinglePostLoaded extends PostState {
  final PostDetailEntity post;

  const SinglePostLoaded(super.posts, this.post);

  @override
  List<Object> get props => [posts, post];
}

class PostError extends PostState {
  final String message;

  const PostError(super.posts, this.message);

  @override
  List<Object> get props => [posts, message];
}
