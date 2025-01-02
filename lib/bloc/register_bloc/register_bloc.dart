import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_bloc_event.dart';
part 'register_bloc_state.dart';

class RegisterBloc extends Bloc<RegisterBlocEvent, RegisterBlocState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  RegisterBloc() : super(RegisterBlocInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      try {
        print("printing " + event.email + event.password);
        print(event.email.toString());
        print(event.password);
        emit(RegisterLoadingState());
        // Firebase user creation
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          
          password: event.password,
          
        );
        

        // Optionally, set additional user data (e.g., name, gender, country, etc.)
        await userCredential.user?.updateDisplayName(event.name);

        emit(RegisterSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(RegisterFailureState(error: e.message ?? 'An error occurred'));
      } catch (e) {
        emit(RegisterFailureState(error: 'An unexpected error occurred'));
      }
    });
    on<CountryChangedEvent>((event, emit) async {
      try {
        // Fetch states and cities based on the selected country
        List<String> states = _getStatesForCountry(event.country);
        List<String> cities = [];

        // Set default cities based on the first state or return empty
        if (states.isNotEmpty) {
          cities = _getCitiesForState(states.first);
        }

        emit(RegisterUpdatedState(states: states, cities: cities));
      } catch (e) {
        emit(RegisterFailureState(
            error: 'Failed to update countries and states'));
      }
    });
    on<StateChangedEvent>((event, emit) async {
      try {
        // Fetch cities based on the selected state
        List<String> cities = _getCitiesForState(event.state);
        emit(RegisterUpdatedState(
            states: [], cities: cities)); // Only update cities
      } catch (e) {
        emit(RegisterFailureState(error: 'Failed to update cities'));
      }
    });
  }

  // Example of fetching states based on country
  List<String> _getStatesForCountry(String country) {
    // Simulate fetching states from an API or database
    if (country == 'USA') {
      return ['California', 'Texas', 'New York'];
    } else if (country == 'India') {
      return ['Maharashtra', 'Karnataka', 'Delhi'];
    } else if (country == 'UK') {
      return ['England', 'Scotland', 'Wales'];
    } else {
      return []; // Empty list if no matching country
    }
  }

  // Example of fetching cities based on state
  List<String> _getCitiesForState(String state) {
    // Simulate fetching cities from an API or database
    if (state == 'California') {
      return ['Los Angeles', 'San Francisco', 'San Diego'];
    } else if (state == 'Texas') {
      return ['Austin', 'Houston', 'Dallas'];
    } else if (state == 'New York') {
      return ['New York City', 'Buffalo', 'Albany'];
    } else if (state == 'Maharashtra') {
      return ['Mumbai', 'Pune', 'Nagpur'];
    } else if (state == 'Karnataka') {
      return ['Bangalore', 'Mysore', 'Mangalore'];
    } else {
      return []; // Empty list if no matching state
    }
  }
}
