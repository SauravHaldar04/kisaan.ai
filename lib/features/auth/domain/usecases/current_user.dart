

import 'package:fpdart/fpdart.dart';
import 'package:nfc3_overload_oblivion/common/entities/user_entity.dart';
import 'package:nfc3_overload_oblivion/common/error/failure.dart';
import 'package:nfc3_overload_oblivion/common/usecase/usecase.dart';
import 'package:nfc3_overload_oblivion/features/auth/domain/repository/auth_repository.dart';



class CurrentUser implements Usecase<User,NoParams>{
  final AuthRepository repository;

  CurrentUser(this.repository);

  @override
  Future<Either<Failure,User>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}