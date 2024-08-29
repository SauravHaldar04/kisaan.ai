
import 'package:fpdart/fpdart.dart';
import 'package:nfc3_overload_oblivion/common/error/failure.dart';

abstract interface class Usecase<SuccessType,Params>{
  Future<Either<Failure,SuccessType>> call(Params params);
}
class NoParams{}