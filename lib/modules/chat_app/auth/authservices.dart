import 'package:firebase_auth/firebase_auth.dart';

class Authservices {
  //instance of firebaseauth
  final auth = FirebaseAuth.instance;

  //login user
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: avoid_print
        print('No user found for that email.');
      }
    }
  }

  //register user
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //logout user
  Future<void> logout() async {
    return await auth.signOut();
  }

  //error
}
