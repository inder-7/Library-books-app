import 'package:flutter/material.dart';
import 'package:library_books_app/book_cubit/book_cubit.dart';
import 'package:library_books_app/book_detail_cubit/book_detail_cubit.dart';
import 'package:library_books_app/pages/book_list/book_list_page.dart';
import 'package:library_books_app/pages/register_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:library_books_app/bloc/register_bloc/register_bloc.dart';

void main() async {
  // Ensure that Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Provide the RegisterBlocBloc to the entire app
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => BookCubit(),
        ),
        BlocProvider(create: (context) => BookDetailCubit())
      ],
      child: MaterialApp(
        title: 'Library Books App',
         theme: ThemeData(
        primaryColor: Colors.blueAccent,
        
        brightness: Brightness.light, // Dark theme for a modern look
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white, // Set title and icon to white
        ),
         ),
        debugShowCheckedModeBanner: false,
        home: RegisterPage(), // Set the RegisterPage as the home screen
      ),
    );
  }
}
