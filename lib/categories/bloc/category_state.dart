part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  const CategorySuccess({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

final class CategoryFailure extends CategoryState {
  final String message;

  const CategoryFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class CategoryCreating
    extends CategoryState {}

final class CategoryCreated
    extends CategoryState {
  final CategoryModel category;

  const CategoryCreated({
    required this.category,
  });

  @override
  List<Object> get props => [
        category,
      ];
}

final class CategoryUpdating
    extends CategoryState {}

final class CategoryUpdated
    extends CategoryState {
  final CategoryModel category;

  const CategoryUpdated({
    required this.category,
  });

  @override
  List<Object> get props => [
        category,
      ];
}

final class CategoryDeleting
    extends CategoryState {}

final class CategoryDeleted
    extends CategoryState {}