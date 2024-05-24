import 'package:equatable/equatable.dart';

class PostDetailEntity extends Equatable {
  final int id;
  final String title;
  final String body;

  const PostDetailEntity({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];
}
