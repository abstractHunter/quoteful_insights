import 'package:quoteful_insights/core/constants/constants.dart';
import 'package:quoteful_insights/features/quote/business/entities/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  const QuoteModel({
    required String quote,
    required String author,
  }) : super(
          quote: quote,
          author: author,
        );

  factory QuoteModel.fromJson({required Map<String, dynamic> json}) {
    return QuoteModel(
      quote: json[kQuote],
      author: json[kAuthor],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kQuote: quote,
      kAuthor: author,
    };
  }
}
