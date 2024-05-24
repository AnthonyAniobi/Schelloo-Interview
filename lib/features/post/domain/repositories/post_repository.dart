import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:schello/features/post/data/datasources/base_request.dart';
import 'package:schello/features/post/data/datasources/custom_type_definintions.dart';
import 'package:schello/features/post/data/models/post.dart';
import 'package:schello/features/post/domain/entities/post_detail_entity.dart';
import 'package:schello/features/post/domain/entities/post_list_entity.dart';

class PostRepository {
  final String baseUrl;
  PostRepository({required this.baseUrl});

  AsyncOrError<List<PostListEntity>> getAll() async {
    final data = await BaseRequest.get("$baseUrl/posts");
    if (data.isRight) {
      final postList = List<Map<String, dynamic>>.from(data.right);
      List<Post> allPost = postList.map((pst) {
        return Post.fromJson(Map<String, dynamic>.from(pst));
      }).toList();
      return Right(allPost
          .map<PostListEntity>((pst) => PostListEntity(pst.id, pst.title))
          .toList());
    } else {
      return Left(data.left);
    }
  }

  AsyncOrError<PostDetailEntity> getOne(int id) async {
    final data = await BaseRequest.get("$baseUrl/posts/$id");
    if (data.isRight) {
      final result = Map<String, dynamic>.from(data.right);
      final post = Post.fromJson(result);
      return Right(
          PostDetailEntity(id: post.id, title: post.title, body: post.body));
    } else {
      return Left(data.left);
    }
  }

  AsyncOrError<PostDetailEntity> addPost(PostDetailEntity entity) async {
    int userId = Random().nextInt(3) + 1;
    Post post = Post(
        userId: userId, id: entity.id, title: entity.title, body: entity.body);
    final data = await BaseRequest.post("$baseUrl/posts", post.toJson());
    if (data.isRight) {
      return Right(entity);
    } else {
      return Left(data.left);
    }
  }
}
