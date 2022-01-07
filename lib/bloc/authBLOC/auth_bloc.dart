import 'package:calendar_it/bloc/authBLOC/auth_event.dart';
import 'package:calendar_it/bloc/authBLOC/auth_state.dart';
import 'package:calendar_it/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(initialState) : super(initialState);
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is SignIn) {
      if(event.isGoogleSignin){
        print("Google Sign In Attempt");
        // UserCredential userCredential = await auth.signI
      }
      else{
        print("Email n Password Sign In Attempt");
        try {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email:event.email,
              password:event.password
          );
          Object object={
            'email':userCredential.user!.email,
            'displayName':userCredential.user!.displayName,
          };
          yield Authenticated(userCredential);
        }
        catch(e){
          print("Unauthenticated");
          yield UnAuthenticated();
        }
        print("Done");
      }
    }
    else if(event is SignOut){
      await auth.signOut();
      yield UnAuthenticated();
    }
    else if(event is SignUp){
      if(event.isGoogleSignup){
        print("Google SignUp Attempt");
      }
      else{
        try{
          UserCredential userCredential =await auth.createUserWithEmailAndPassword(
              email: event.email, password:event.password
          );
          yield Authenticated(userCredential);
        }
        catch(e) {
          yield UnAuthenticated();
        }
      }
    }
  }
}