import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    super.email,
    super.roleId = 1,
    super.preferences = const {},
    super.isActive = true,
  });

  factory UserProfileModel.fromRemote(
    Map<String, dynamic> json, {
    String? email,
  }) {
    return UserProfileModel(
      id: json['id_usuario'] as String,
      email: email,
      roleId: (json['id_rol'] as num?)?.toInt() ?? 1,
      preferences: json['preferencias'] is Map<String, dynamic>
          ? (json['preferencias'] as Map<String, dynamic>)
          : <String, dynamic>{},
      isActive: json['activo'] as bool? ?? true,
    );
  }

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      id: entity.id,
      email: entity.email,
      roleId: entity.roleId,
      preferences: entity.preferences,
      isActive: entity.isActive,
    );
  }

  Map<String, dynamic> toRemoteMap() {
    return {
      'id_usuario': id,
      'id_rol': roleId,
      'preferencias': preferences,
      'activo': isActive,
      if (email != null) 'usu_cre': email,
    };
  }
}

