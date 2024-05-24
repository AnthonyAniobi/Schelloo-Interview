import 'package:either_dart/either.dart';
import 'package:schello/features/post/data/models/app_error.dart';

typedef AsyncOrError<T> = Future<Either<AppError, T>>;
