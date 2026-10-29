import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_profile_model.dart';

abstract class AuthRemoteDataSource {
  Stream<AuthState> watchAuthState();
  User? getCurrentAuthUser();
  Future<UserProfileModel?> getUserProfile(String userId);
  Future<UserProfileModel> upsertUserProfile(UserProfileModel model);
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  });
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<void> signInWithGoogle();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _client = supabaseClient;

  final SupabaseClient _client;

  @override
  Stream<AuthState> watchAuthState() {
    return _client.auth.onAuthStateChange;
  }

  @override
  User? getCurrentAuthUser() {
    return _client.auth.currentUser;
  }

  @override
  Future<UserProfileModel?> getUserProfile(String userId) async {
    final response = await _client
        .from('usuarios')
        .select()
        .eq('id_usuario', userId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    final currentUser = _client.auth.currentUser;
    return UserProfileModel.fromRemote(
      response,
      email: currentUser?.id == userId ? currentUser?.email : null,
    );
  }

  @override
  Future<UserProfileModel> upsertUserProfile(UserProfileModel model) async {
    final payload = model.toRemoteMap();
    final response = await _client
        .from('usuarios')
        .upsert(payload)
        .select()
        .single();

    return UserProfileModel.fromRemote(response, email: model.email);
  }

  @override
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.fastrecipe://login-callback/',
    );
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}

