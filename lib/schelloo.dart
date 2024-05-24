import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schello/features/post/domain/repositories/post_repository.dart';
import 'package:schello/features/post/presentation/bloc/post_bloc.dart';
import 'package:schello/features/post/presentation/pages/post_list_page.dart';

class Schelloo extends StatelessWidget {
  const Schelloo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final PostRepository postRepository =
        PostRepository(baseUrl: 'https://jsonplaceholder.typicode.com');

    return BlocProvider(
      create: (context) => PostBloc(postRepository)..add(GetPostsEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PostListPage(),
      ),
    );
  }
}
