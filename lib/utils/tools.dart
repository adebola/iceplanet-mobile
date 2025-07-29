import 'package:currency_formatter/currency_formatter.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var nairaSettings = const CurrencyFormat(
  symbol: '₦',
  code: 'ngn',
  symbolSide: SymbolSide.left,
);