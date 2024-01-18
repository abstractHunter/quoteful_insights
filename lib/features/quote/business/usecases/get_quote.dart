import 'package:dartz/dartz.dart';
import 'package:quoteful_insights/core/errors/failure.dart';
import 'package:quoteful_insights/core/params/params.dart';
import 'package:quoteful_insights/features/quote/business/entities/quote_entity.dart';
import 'package:quoteful_insights/features/quote/business/repositories/quote_repository.dart';

class GetQuote {
  final QuoteRepository repository;

  GetQuote(this.repository);

  Future<Either<Failure, QuoteEntity>> call(
      {required QuoteParams params}) async {
    return await repository.getRandomQuote(params: params);
  }
}
