part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostEvent {}

class GetPostEvent extends PostEvent {
  final int id;

  const GetPostEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreatePostEvent extends PostEvent {
  final PostDetailEntity post;

  const CreatePostEvent(this.post);

  @override
  List<Object> get props => [post];
}
