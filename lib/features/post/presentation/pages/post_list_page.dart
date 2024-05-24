import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schello/features/post/presentation/bloc/post_bloc.dart';
import 'package:schello/features/post/presentation/pages/create_post_page.dart';
import 'package:schello/features/post/presentation/pages/post_detail_page.dart';
import 'package:schello/features/post/presentation/widgets/error_banner.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(GetPostsEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<PostBloc>().add(GetPostsEvent());
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.posts.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(),
                const Text('Post not found'),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<PostBloc>().add(GetPostsEvent());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reload"),
                ),
              ],
            );
          }
          return Column(
            children: [
              if (state is PostError) ErrorBanner(message: state.message),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          post.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailPage(id: post.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePostPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
