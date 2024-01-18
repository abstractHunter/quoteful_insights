import 'package:dartz/dartz.dart';
import 'package:quoteful_insights/core/errors/failure.dart';
import 'package:quoteful_insights/core/params/params.dart';
import 'package:quoteful_insights/features/quote/business/entities/quote_entity.dart';

abstract class QuoteRepository {
  Future<Either<Failure, QuoteEntity>> getRandomQuote(
      {required QuoteParams params});
}
