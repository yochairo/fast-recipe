import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._repository);

  final AuthRepository _repository;

  Stream<UserProfile?> call() => _repository.watchAuthState();
}

