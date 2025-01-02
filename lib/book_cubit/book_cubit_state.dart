part of 'book_cubit.dart';


@immutable
sealed class BookCubitState {}

final class BookCubitInitial extends BookCubitState {}

final class BookCubitLoading extends BookCubitState {}

final class BookCubitLoaded extends BookCubitState {
  final List<Book> books;

  BookCubitLoaded(this.books);
}

final class BookCubitError extends BookCubitState {
  final String message;

  BookCubitError(this.message);
}
