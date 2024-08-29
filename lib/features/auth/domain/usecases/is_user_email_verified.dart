
import 'package:fpdart/fpdart.dart';
import 'package:nfc3_overload_oblivion/common/error/failure.dart';
import 'package:nfc3_overload_oblivion/common/usecase/usecase.dart';
import 'package:nfc3_overload_oblivion/features/auth/domain/repository/auth_repository.dart';

class IsUserEmailVerified implements Usecase<bool, NoParams> {
  final AuthRepository repository;

  IsUserEmailVerified(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isUserEmailVerified();
  }
}