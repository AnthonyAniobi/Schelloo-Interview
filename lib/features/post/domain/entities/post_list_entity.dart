import 'package:equatable/equatable.dart';

class PostListEntity extends Equatable {
  final String title;
  final int id;

  const PostListEntity(this.id, this.title);

  @override
  List<Object?> get props => [id, title];
}
