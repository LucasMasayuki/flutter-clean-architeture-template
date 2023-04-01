import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture_template/features/counter/domain/entities/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/cache_failure.dart';

const cacheControl = 'CACHED_COUNTER';

abstract class CounterLocalDataSource {
  Either<CacheFailure, Counter> getLastCounter();
  Future<void> saveCounter(Counter counterToCache);
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CounterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Either<CacheFailure, Counter> getLastCounter() {
    final jsonString = sharedPreferences.getString(cacheControl);
    if (jsonString != null) {
      return Right(Counter.fromJson(json.decode(jsonString)));
    }

    throw Left(CacheFailure(message: ''));
  }

  @override
  Future<void> saveCounter(Counter counterToCache) {
    return sharedPreferences.setString(
      cacheControl,
      json.encode(counterToCache.toJson()),
    );
  }
}
