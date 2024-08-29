import 'package:fpdart/fpdart.dart';
import 'package:nfc3_overload_oblivion/common/entities/user_entity.dart';
import 'package:nfc3_overload_oblivion/common/error/failure.dart';
import 'package:nfc3_overload_oblivion/common/usecase/usecase.dart';
import 'package:nfc3_overload_oblivion/features/auth/domain/repository/auth_repository.dart';

class UserSignup implements Usecase<User, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signInWithEmailAndPassword(
        name: params.name,
        landArea: params.landArea,
        irrigationMethod: params.irrigationMethod,
        email: params.email,
        password: params.password);
  }
}

class UserSignupParams {
  final String name;
  final double landArea;
  final String irrigationMethod;
  final String email;
  final String password;

  UserSignupParams(
      {required this.name,
      required this.landArea,
      required this.irrigationMethod,
      required this.email,
      required this.password});
}
