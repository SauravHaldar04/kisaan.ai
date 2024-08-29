part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String name;
  final double landArea;
  final String irrigationMethod;
  final String email;
  final String password;
  AuthSignUp(this.email, this.password, this.name, this.landArea,
      this.irrigationMethod);
}

final class AuthLogIn extends AuthEvent {
  final String email;
  final String password;
  AuthLogIn(this.email, this.password);
}

final class AuthEmailVerification extends AuthEvent {}

final class AuthGoogleSignIn extends AuthEvent {}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthIsUserEmailVerified extends AuthEvent {}

class AuthEmailVerificationCompleted extends AuthEvent {}

class AuthEmailVerificationFailed extends AuthEvent {
  final String message;
  AuthEmailVerificationFailed(this.message);
}
