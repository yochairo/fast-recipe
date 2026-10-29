import 'package:fast_recipe/features/auth/data/models/user_profile_model.dart';
import 'package:fast_recipe/features/auth/domain/entities/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserProfile & UserProfileModel', () {
    test('instantiates correctly with default roleId 1', () {
      const user = UserProfile(id: 'uuid-123', email: 'test@example.com');
      expect(user.roleId, 1);
      expect(user.isActive, true);
      expect(user.preferences, isEmpty);
    });

    test('UserProfileModel fromRemote maps SQL usuarios schema correctly', () {
      final remoteJson = {
        'id_usuario': 'uuid-456',
        'id_rol': 1,
        'preferencias': {'vegetarian': true},
        'activo': true,
      };

      final model = UserProfileModel.fromRemote(
        remoteJson,
        email: 'chef@example.com',
      );

      expect(model.id, 'uuid-456');
      expect(model.roleId, 1);
      expect(model.email, 'chef@example.com');
      expect(model.preferences['vegetarian'], true);
      expect(model.isActive, true);
    });

    test('UserProfileModel toRemoteMap exports matching fields', () {
      const model = UserProfileModel(
        id: 'uuid-789',
        email: 'user@example.com',
        roleId: 1,
        preferences: {'spicy': false},
        isActive: true,
      );

      final map = model.toRemoteMap();

      expect(map['id_usuario'], 'uuid-789');
      expect(map['id_rol'], 1);
      expect(map['preferencias'], {'spicy': false});
      expect(map['activo'], true);
      expect(map['usu_cre'], 'user@example.com');
    });
  });
}

