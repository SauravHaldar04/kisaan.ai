
import 'package:fpdart/fpdart.dart';
import 'package:nfc3_overload_oblivion/common/error/failure.dart';
import 'package:nfc3_overload_oblivion/common/usecase/usecase.dart';
import 'package:nfc3_overload_oblivion/features/auth/domain/repository/auth_repository.dart';

class VerifyUserEmail implements Usecase<void,NoParams> {
  final AuthRepository authRepository;
  const VerifyUserEmail(this.authRepository);
  @override
  Future<Either<Failure,bool>> call(NoParams params) async{
    return authRepository.verifyEmail();
  }
}
