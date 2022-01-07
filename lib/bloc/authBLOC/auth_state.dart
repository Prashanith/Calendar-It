import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable{
  final UserCredential userCredential;
  const AuthenticationState(this.userCredential):super();

  @override
  List<UserCredential> get props => [userCredential];
}

class Authenticated extends AuthenticationState{
  const Authenticated(UserCredential userCredential): super(userCredential);

  @override
  List<UserCredential> get props => [userCredential];
}

class UnAuthenticated extends AuthenticationState{
  const UnAuthenticated() : super();

  @override
  List<UserCredential> get props => [];
}
