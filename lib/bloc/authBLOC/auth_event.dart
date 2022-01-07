abstract class AuthenticationEvent{
  const AuthenticationEvent();
}

class SignIn extends AuthenticationEvent{
  const SignIn({
    required this.isGoogleSignin,
    required this.email,
    required this.password
  });
  final bool isGoogleSignin;
  final String email;
  final String password;
}

class SignOut extends AuthenticationEvent{
  const SignOut();
}

class SignUp extends AuthenticationEvent{
  const SignUp({
    required this.isGoogleSignup,
    required this.email,
    required this.password
  });

  final bool isGoogleSignup;
  final String email;
  final String password;
}



