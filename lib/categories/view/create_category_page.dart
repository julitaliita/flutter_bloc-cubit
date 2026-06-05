import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/category_bloc.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({super.key});

  @override
  State<CreateCategoryPage> createState() =>
      _CreateCategoryPageState();
}

class _CreateCategoryPageState
    extends State<CreateCategoryPage> {
  final _nameController =
      TextEditingController();

  final _descriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Category',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:
                  _nameController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Category Name',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  _descriptionController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Description',
              ),
            ),

            const SizedBox(height: 24),

            BlocConsumer<
                CategoryBloc,
                CategoryState>(
              listener:
                  (context, state) {
                if (state
                    is CategoryCreated) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Category berhasil dibuat',
                      ),
                    ),
                  );

                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },
              builder:
                  (context, state) {
                if (state
                    is CategoryCreating) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () async {
                    final prefs =
                        await SharedPreferences
                            .getInstance();

                    final token =
                        prefs.getString(
                      'token',
                    );

                    if (token ==
                        null) {
                      return;
                    }

                    context
                        .read<
                            CategoryBloc>()
                        .add(
                          CreateCategory(
                            token:
                                token,
                            name:
                                _nameController
                                    .text,
                            description:
                                _descriptionController
                                    .text,
                          ),
                        );
                  },
                  child: const Text(
                    'Simpan',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}