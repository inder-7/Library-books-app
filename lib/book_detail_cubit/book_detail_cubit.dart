import 'dart:convert';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:library_books_app/models/book_detail.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'book_detail_cubit_state.dart';

class BookDetailCubit extends Cubit<BookDetailCubitState> {
  BookDetailCubit() : super(BookDetailCubitInitial());
  Future<void> fetchBookDetail(String bookId) async {
    emit(BookDetailCubitLoading());
    try {

    final url = Uri.parse('https://www.googleapis.com/books/v1/volumes/$bookId');

    final response = await http.get(url);
    
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data.toString());
         emit(BookDetailCubitLoaded(bookDetail: BookDetail.fromJson(data))); 
      } else {
        throw BookDetailCubitError(message: 'Failed to fetch book details');
      }
    } catch (e) {
      emit(BookDetailCubitError(message: "An error occoured $e"));
    }
  }
}
