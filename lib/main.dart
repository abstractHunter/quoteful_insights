import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoteful_insights/features/quote/presentation/pages/quote_page.dart';
import 'package:quoteful_insights/features/quote/presentation/providers/quote_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuoteProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<QuoteProvider>(context, listen: false).eitherFailureOrQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const QuotePage();
  }
}
