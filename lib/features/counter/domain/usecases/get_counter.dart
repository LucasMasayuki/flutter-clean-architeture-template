import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase.dart';
import '../../repositories/counter_repository.dart';
import '../entities/counter.dart';

class GetCounterUseCase extends UseCase<Counter, NoParams> {
  final CounterRepository repository;

  GetCounterUseCase({required this.repository});

  @override
  Future<Either<Failure, Counter>> call(NoParams params) async {
    return repository.getCounter();
  }
}
