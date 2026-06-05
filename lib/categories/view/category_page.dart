import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/category_bloc.dart';
import 'create_category_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}aku

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();

    loadCategory();
  }

  Future<void> loadCategory() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    if (token != null) {
      context.read<CategoryBloc>().add(LoadCategories(token: token));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateCategoryPage()),
          );

          if (result == true) {
            loadCategory();
          }
        },
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CategoryFailure) {
            return Center(child: Text(state.message));
          }

          if (state is CategorySuccess) {
            if (state.categories.isEmpty) {
              return const Center(child: Text("Belum ada category"));
            }

            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(category.name),
                    subtitle: Text(category.description),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            // nanti Edit Category
                          },
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            print("TOMBOL DELETE DIKLIK");

                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text('Hapus Category'),
                                  content: Text(
                                    'Yakin ingin menghapus ${category.name} ?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text('Hapus'),
                                    ),
                                  ],
                                );
                              },
                            );

                            print("HASIL DIALOG : $confirm");

                            if (confirm == true) {
                              print("USER MENEKAN HAPUS");

                              final prefs =
                                  await SharedPreferences.getInstance();

                              final token = prefs.getString('token');

                              if (token != null) {
                                context.read<CategoryBloc>().add(
                                  DeleteCategory(
                                    token: token,
                                    documentId: category.documentId,
                                  ),
                                );

                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    loadCategory();
                                  },
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
