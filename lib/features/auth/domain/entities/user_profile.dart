import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    this.email,
    this.roleId = 1,
    this.preferences = const {},
    this.isActive = true,
  });

  final String id;
  final String? email;
  final int roleId;
  final Map<String, dynamic> preferences;
  final bool isActive;

  UserProfile copyWith({
    String? id,
    String? email,
    int? roleId,
    Map<String, dynamic>? preferences,
    bool? isActive,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      preferences: preferences ?? this.preferences,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [id, email, roleId, preferences, isActive];
}

