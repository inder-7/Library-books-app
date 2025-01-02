import 'package:bloc/bloc.dart';
import 'package:library_books_app/models/book.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


part 'book_cubit_state.dart';

class BookCubit extends Cubit<BookCubitState> {
  BookCubit() : super(BookCubitInitial());

  Future<void> fetchBooksByCategory(String category) async {
    emit(BookCubitLoading());
    try {
      final url = Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=subject:$category');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Book> books = (data['items'] as List)
            .map((item) => Book.fromJson(item))
            .toList();
        emit(BookCubitLoaded(books));
      } else {
        emit(BookCubitError('Failed to fetch books.'));
      }
    } catch (e) {
      emit(BookCubitError('An error occurred: $e'));
    }
  }
}
