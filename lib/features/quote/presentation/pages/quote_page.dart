import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoteful_insights/features/quote/presentation/providers/quote_provider.dart';
import 'package:quoteful_insights/features/quote/presentation/widgets/quote_widget.dart';

class QuotePage extends StatelessWidget {
  const QuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: QuoteWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<QuoteProvider>(context, listen: false)
              .eitherFailureOrQuote();
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
