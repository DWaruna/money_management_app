class TransactionModel {
  final String iconName;
  final String titale;
  final DateTime date;
  final double amount;
  final bool isExpenses;

  TransactionModel({
    required this.iconName,
    required this.titale,
    required this.date,
    required this.amount,
    required this.isExpenses
  });
}