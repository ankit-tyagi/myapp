class Currency {
  final String code;
  final String symbol;
  final String name;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
  });
}

const List<Currency> currencies = [
  Currency(code: 'USD', symbol: '\$', name: 'US Dollar'),
  Currency(code: 'EUR', symbol: '€', name: 'Euro'),
  Currency(code: 'GBP', symbol: '£', name: 'British Pound'),
  Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen'),
  Currency(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar'),
  Currency(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar'),
  Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee'),
  Currency(code: 'CNY', symbol: '¥', name: 'Chinese Yuan'),
  Currency(code: 'CHF', symbol: 'CHF', name: 'Swiss Franc'),
  Currency(code: 'RUB', symbol: '₽', name: 'Russian Ruble'),
  Currency(code: 'BRL', symbol: 'R\$', name: 'Brazilian Real'),
  Currency(code: 'ZAR', symbol: 'R', name: 'South African Rand'),
  Currency(code: 'KRW', symbol: '₩', name: 'South Korean Won'),
  Currency(code: 'TRY', symbol: '₺', name: 'Turkish Lira'),
  Currency(code: 'MXN', symbol: 'Mex\$', name: 'Mexican Peso'),
  Currency(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar'),
  Currency(code: 'NZD', symbol: 'NZ\$', name: 'New Zealand Dollar'),
  Currency(code: 'HKD', symbol: 'HK\$', name: 'Hong Kong Dollar'),
  Currency(code: 'SEK', symbol: 'kr', name: 'Swedish Krona'),
  Currency(code: 'NOK', symbol: 'kr', name: 'Norwegian Krone'),
  Currency(code: 'DKK', symbol: 'kr', name: 'Danish Krone'),
  Currency(code: 'PLN', symbol: 'zł', name: 'Polish Złoty'),
  Currency(code: 'THB', symbol: '฿', name: 'Thai Baht'),
  Currency(code: 'IDR', symbol: 'Rp', name: 'Indonesian Rupiah'),
  Currency(code: 'MYR', symbol: 'RM', name: 'Malaysian Ringgit'),
  Currency(code: 'PHP', symbol: '₱', name: 'Philippine Peso'),
  Currency(code: 'VND', symbol: '₫', name: 'Vietnamese Dong'),
];
