// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthObject{
//   final UserCredential userCredential;
//   final bool isLoggedIn;
//   final String error;
// }
//
// class AuthService {
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future login(String email, String password) async {
//     try {
//       UserCredential user = await auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     }
//     on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         return Exception("User Not Found");
//
//       } else if (e.code == 'wrong-password') {
//
//
//       }
//     }
//     catch(e){
//
//
//     }
//   }
// }