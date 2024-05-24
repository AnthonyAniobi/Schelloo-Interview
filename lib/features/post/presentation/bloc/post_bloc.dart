import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schello/features/post/domain/entities/post_detail_entity.dart';
import 'package:schello/features/post/domain/entities/post_list_entity.dart';
import 'package:schello/features/post/domain/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repo;

  PostBloc(this.repo) : super(PostInitial()) {
    on<GetPostsEvent>(_getAllPosts);
    on<GetPostEvent>(_getOnePost);
    on<CreatePostEvent>(_addPost);
  }

  Future<void> _getAllPosts(
      GetPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading(state.posts));
    final result = await repo.getAll();
    result.fold((left) {
      emit(PostError(state.posts, left.message));
    }, (right) {
      emit(PostLoaded(right));
    });
  }

  Future<void> _addPost(CreatePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading(state.posts));
    final result = await repo.addPost(event.post);
    result.fold((left) {
      emit(PostError(state.posts, left.message));
    }, (right) {
      emit(SinglePostLoaded(state.posts, right));
      emit(
        PostLoaded(
          state.posts..add(PostListEntity(right.id, right.title)),
        ),
      );
    });
  }

  Future<void> _getOnePost(GetPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading(state.posts));
    final result = await repo.getOne(event.id);
    result.fold((left) {
      emit(PostError(state.posts, left.message));
    }, (right) {
      emit(SinglePostLoaded(state.posts, right));
    });
  }
}
