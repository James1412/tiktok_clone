import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedin => user != null;
  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authStateStream = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
