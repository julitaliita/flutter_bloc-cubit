part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories
    extends CategoryEvent {
  final String token;

  const LoadCategories({
    required this.token,
  });

  @override
  List<Object> get props => [
        token,
      ];
}

class CreateCategory
    extends CategoryEvent {
  final String token;
  final String name;
  final String description;

  const CreateCategory({
    required this.token,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [
        token,
        name,
        description,
      ];
}

class UpdateCategory extends CategoryEvent {
  final String token;
  final int id;
  final String name;
  final String description;

  const UpdateCategory({
    required this.token,
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [
        token,
        id,
        name,
        description,
      ];
}

class DeleteCategory extends CategoryEvent {
  final String token;
  final String documentId;

  const DeleteCategory({
    required this.token,
    required this.documentId,
  });

  @override
  List<Object> get props => [
        token,
        documentId,
      ];
}