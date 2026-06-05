import 'package:flutter/material.dart';
import 'package:flutter_counter_bloc/posts/view/posts_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PostsList();
  }
}