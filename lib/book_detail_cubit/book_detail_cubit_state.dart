part of 'book_detail_cubit.dart';

@immutable
sealed class BookDetailCubitState {}

final class BookDetailCubitInitial extends BookDetailCubitState {}

final class BookDetailCubitLoading extends BookDetailCubitState {}
final class BookDetailCubitLoaded extends BookDetailCubitState {
  final BookDetail bookDetail;

  BookDetailCubitLoaded({required this.bookDetail});

}
final class BookDetailCubitError extends BookDetailCubitState {
  final String  message;

  BookDetailCubitError({required this.message});
}
