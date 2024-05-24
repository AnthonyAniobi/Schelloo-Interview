import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schello/features/post/presentation/bloc/post_bloc.dart';

class PostDetailPage extends StatelessWidget {
  final int id;

  const PostDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(GetPostEvent(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Post Detail')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SinglePostLoaded) {
            final post = state.post;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    post.title,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(post.body),
                ],
              ),
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(),
              const Text('Post not found'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<PostBloc>().add(GetPostEvent(id));
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Reload"),
              ),
            ],
          );
        },
      ),
    );
  }

  void reload() {}
}
