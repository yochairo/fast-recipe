import 'package:equatable/equatable.dart';

class AuthFailure extends Equatable implements Exception {
  const AuthFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'AuthFailure: $message';
}

