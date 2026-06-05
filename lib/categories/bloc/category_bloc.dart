import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/category_model.dart';
import '../repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc
    extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({
    required this.categoryRepository,
  }) : super(CategoryInitial()) {
    on<LoadCategories>(
      _onLoadCategories,
    );

    on<CreateCategory>(
      _onCreateCategory,
    );

    on<UpdateCategory>(
      _onUpdateCategory,
    );

    on<DeleteCategory>(
      _onDeleteCategory,
    );
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    try {
      final categories =
          await categoryRepository.getCategories(
        token: event.token,
      );

      emit(
        CategorySuccess(
          categories: categories,
        ),
      );
    } catch (e) {
      emit(
        CategoryFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCreateCategory(
    CreateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryCreating());

    try {
      final category =
          await categoryRepository.createCategory(
        token: event.token,
        name: event.name,
        description: event.description,
      );

      emit(
        CategoryCreated(
          category: category,
        ),
      );
    } catch (e) {
      emit(
        CategoryFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryUpdating());

    try {
      final category =
          await categoryRepository.updateCategory(
        token: event.token,
        id: event.id,
        name: event.name,
        description: event.description,
      );

      emit(
        CategoryUpdated(
          category: category,
        ),
      );
    } catch (e) {
      emit(
        CategoryFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    print("EVENT DELETE MASUK");
    emit(CategoryDeleting());

    try {
      await categoryRepository.deleteCategory(
        token: event.token,
        documentId: event.documentId,
      );

      emit(
        CategoryDeleted(),
      );
    } catch (e) {
      emit(
        CategoryFailure(
          message: e.toString(),
        ),
      );
    }
  }
}