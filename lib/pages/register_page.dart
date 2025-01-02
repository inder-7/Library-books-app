import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_books_app/bloc/register_bloc/register_bloc.dart';
import 'package:library_books_app/pages/book_list/book_list_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String gender = 'Male';
  String country = 'USA';
  String state = 'California';
  String city = 'Los Angeles';

  List<String> genders = ['Male', 'Female', 'Other'];
  List<String> countries = ['USA', 'India', 'UK', 'Canada'];
  List<String> states = ['California', 'Texas', 'New York', 'Florida'];
  List<String> cities = ['Los Angeles', 'New York', 'San Francisco', 'Chicago'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<RegisterBloc, RegisterBlocState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registering...')),
            );
          } else if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration successful!'), backgroundColor: Colors.green),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BookListScreen()),
            );
          } else if (state is RegisterFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}'), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, blocState) {
          List<String> updatedStates = states;
          List<String> updatedCities = cities;

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name TextField
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColorDark),
                        ),
                        prefixIcon: Icon(Icons.person, color: theme.primaryColor),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => name = value),
                    ),
                    SizedBox(height: 16),

                    // Email TextField
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColorDark),
                        ),
                        prefixIcon: Icon(Icons.email, color: theme.primaryColor),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => email = value),
                    ),
                    SizedBox(height: 16),

                    // Password TextField
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColorDark),
                        ),
                        prefixIcon: Icon(Icons.lock, color: theme.primaryColor),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => password = value),
                    ),
                    SizedBox(height: 16),

                    // Gender Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColorDark),
                        ),
                        prefixIcon: Icon(Icons.person, color: theme.primaryColor),
                      ),
                      value: gender,
                      items: genders.map((genderOption) {
                        return DropdownMenuItem<String>(
                          value: genderOption,
                          child: Text(genderOption),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => gender = value!),
                    ),
                    SizedBox(height: 16),

                    // Country Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Country',
                        labelStyle: TextStyle(color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColorDark),
                        ),
                        prefixIcon: Icon(Icons.flag, color: theme.primaryColor),
                      ),
                      value: country,
                      items: countries.map((countryOption) {
                        return DropdownMenuItem<String>(
                          value: countryOption,
                          child: Text(countryOption),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          country = value!;
                          context.read<RegisterBloc>().add(CountryChangedEvent(country: value));
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    // State Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'State',
                        labelStyle: TextStyle(color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColorDark),
                        ),
                        prefixIcon: Icon(Icons.location_city, color: theme.primaryColor),
                      ),
                      value: state,
                      items: updatedStates.map((stateOption) {
                        return DropdownMenuItem<String>(
                          value: stateOption,
                          child: Text(stateOption),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => state = value!),
                    ),
                    SizedBox(height: 16),

                    // City Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle: TextStyle(color: theme.primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: theme.primaryColorDark),
                        ),
                        prefixIcon: Icon(Icons.location_on, color: theme.primaryColor),
                      ),
                      value: city,
                      items: updatedCities.map((cityOption) {
                        return DropdownMenuItem<String>(
                          value: cityOption,
                          child: Text(cityOption),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => city = value!),
                    ),
                    SizedBox(height: 20),

                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<RegisterBloc>().add(
                            RegisterUserEvent(
                              name: name,
                              email: email,
                              password: password,
                              gender: gender,
                              country: country,
                              state: state,
                              city: city,
                            ),
                          );
                        }
                      },
                      child: Text('Register', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor, // Theme color for button
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40), // Larger padding
                        textStyle: TextStyle(fontSize: 20), // Bigger text
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Circular button
                        ),
                        minimumSize: Size(double.infinity, 60), // Make button larger
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
