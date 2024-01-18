import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoteful_insights/core/errors/failure.dart';
import 'package:quoteful_insights/features/quote/business/entities/quote_entity.dart';
import 'package:quoteful_insights/features/quote/presentation/providers/quote_provider.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteEntity? quote = Provider.of<QuoteProvider>(context).quote;
    Failure? failure = Provider.of<QuoteProvider>(context).failure;
    late Widget widget;

    if (quote != null) {
      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\"${quote.quote}\"",
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 32),
          Text(
            quote.author,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else if (failure != null) {
      widget = Center(
        child: Text(
          failure.errorMessage,
          style: const TextStyle(fontSize: 20),
        ),
      );
    } else {
      widget = const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: widget,
    );
  }
}
