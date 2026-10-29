import '../entities/user_profile.dart';

abstract class AuthRepository {
  Stream<UserProfile?> watchAuthState();
  Future<UserProfile?> getCurrentUser();
  Future<UserProfile> signInWithEmail({
    required String email,
    required String password,
  });
  Future<UserProfile> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<void> signInWithGoogle();
  Future<void> signOut();
}

