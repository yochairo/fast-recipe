import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  final AuthRemoteDataSource _remote;

  @override
  Stream<UserProfile?> watchAuthState() {
    return _remote.watchAuthState().asyncMap((state) async {
      final user = state.session?.user;
      if (user == null) return null;

      try {
        final profile = await _remote.getUserProfile(user.id);
        if (profile != null) return profile;

        final initial = UserProfileModel(
          id: user.id,
          email: user.email,
          roleId: 1,
          preferences: const {},
          isActive: true,
        );
        return await _remote.upsertUserProfile(initial);
      } catch (_) {
        return UserProfile(
          id: user.id,
          email: user.email,
          roleId: 1,
          preferences: const {},
          isActive: true,
        );
      }
    });
  }

  @override
  Future<UserProfile?> getCurrentUser() async {
    try {
      final authUser = _remote.getCurrentAuthUser();
      if (authUser == null) return null;

      final profile = await _remote.getUserProfile(authUser.id);
      if (profile != null) return profile;

      return UserProfile(
        id: authUser.id,
        email: authUser.email,
        roleId: 1,
        preferences: const {},
        isActive: true,
      );
    } catch (error) {
      throw _mapInfraError(error);
    }
  }

  @override
  Future<UserProfile> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.signInWithEmail(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw const AuthFailure('Usuario no encontrado.');
      }

      final profile = await _remote.getUserProfile(user.id);
      if (profile != null) return profile;

      final initial = UserProfileModel(
        id: user.id,
        email: user.email,
        roleId: 1,
        preferences: const {},
        isActive: true,
      );
      return await _remote.upsertUserProfile(initial);
    } catch (error) {
      throw _mapInfraError(error);
    }
  }

  @override
  Future<UserProfile> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.signUpWithEmail(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw const AuthFailure('No se pudo registrar la cuenta.');
      }

      final initial = UserProfileModel(
        id: user.id,
        email: user.email,
        roleId: 1,
        preferences: const {},
        isActive: true,
      );

      // Si la sesión está activa de inmediato (auto-confirmación), guardamos/obtenemos perfil
      if (response.session != null) {
        final existingProfile = await _remote.getUserProfile(user.id);
        if (existingProfile != null) {
          return existingProfile;
        }
        return await _remote.upsertUserProfile(initial);
      }

      // Si requiere confirmación de correo (response.session == null), retornamos el perfil inicial
      // para que la interfaz presente la pantalla de confirmación de correo
      return initial;
    } catch (error) {
      throw _mapInfraError(error);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      await _remote.signInWithGoogle();
    } catch (error) {
      throw _mapInfraError(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _remote.signOut();
    } catch (error) {
      throw _mapInfraError(error);
    }
  }

  AuthFailure _mapInfraError(Object error) {
    if (error is AuthFailure) return error;
    if (error is AuthException) {
      final msg = error.message.toLowerCase();
      if (msg.contains('email not confirmed')) {
        return const AuthFailure(
          'Tu correo aún no ha sido confirmado. Por favor revisa tu bandeja de entrada o spam.',
        );
      }
      if (msg.contains('invalid login credentials')) {
        return const AuthFailure('Correo o contraseña incorrectos.');
      }
      if (msg.contains('user already registered')) {
        return const AuthFailure('Ya existe una cuenta con este correo electrónico.');
      }
      return AuthFailure(error.message);
    }
    if (error is PostgrestException) return AuthFailure(error.message);
    if (error is SocketException) {
      return const AuthFailure('Sin conexión a internet.');
    }
    return AuthFailure(error.toString());
  }
}

