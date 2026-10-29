import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmailUseCase {
  const SignUpWithEmailUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserProfile> call({
    required String email,
    required String password,
  }) {
    return _repository.signUpWithEmail(email: email, password: password);
  }
}

