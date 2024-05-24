import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:schello/features/post/data/datasources/custom_type_definintions.dart';
import 'package:schello/features/post/data/models/app_error.dart';

class BaseRequest {
  static AsyncOrError<dynamic> get(String url, {int timeout = 20}) async {
    try {
      // close any previous request before this call
      Dio().close(force: true);
      final response = await Dio().get(url).timeout(Duration(seconds: timeout));
      Dio().close();
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(AppError(response.statusCode!, response.data));
      }
    } on TimeoutException catch (e) {
      Dio().close(force: true);
      return Left(AppError(408, e.message ?? ""));
    } on SocketException catch (e) {
      Dio().close(force: true);
      return Left(AppError(50, e.message));
    } on DioException catch (e) {
      Dio().close(force: true);
      return Left(AppError(50, e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(0, e.toString()));
    }
  }

  static AsyncOrError<dynamic> post(String url, Object? body,
      {int timeout = 20}) async {
    try {
      // close any previous request before this call
      Dio().close(force: true);
      Response response =
          await Dio().post(url, data: body).timeout(Duration(seconds: timeout));
      Dio().close(force: true);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(AppError(response.statusCode!, response.data));
      }
    } on TimeoutException catch (e) {
      Dio().close(force: true);
      return Left(AppError(408, e.message ?? ""));
    } on SocketException catch (e) {
      Dio().close(force: true);
      return Left(AppError(50, e.message));
    } on DioException catch (e) {
      Dio().close(force: true);
      return Left(AppError(50, e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(0, e.toString()));
    }
  }
}
