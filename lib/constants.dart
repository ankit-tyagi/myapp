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
];
