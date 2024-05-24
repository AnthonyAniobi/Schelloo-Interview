import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schello/features/post/domain/entities/post_detail_entity.dart';
import 'package:schello/features/post/presentation/bloc/post_bloc.dart';
import 'package:schello/features/post/presentation/widgets/error_banner.dart';
import 'package:schello/features/post/presentation/widgets/post_field.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is SinglePostLoaded) {
            // navigate to last
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "${state.post.title} saved");
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (state is PostError) ErrorBanner(message: state.message),
                  PostField(cntrl: titleController, hint: "Title"),
                  PostField(cntrl: bodyController, hint: "Body"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: submit, child: const Text("Create Post"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      PostDetailEntity newPost = PostDetailEntity(
        id: 1,
        title: titleController.text,
        body: bodyController.text,
      );
      context.read<PostBloc>().add(CreatePostEvent(newPost));
    }
  }
}
