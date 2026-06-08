class TransactionModel {
  final int id;
  final String iconName;
  final String titale;
  final DateTime date;
  final double amount;
  final bool isExpenses;

  TransactionModel({
    required this.id,
    required this.iconName,
    required this.titale,
    required this.date,
    required this.amount,
    required this.isExpenses
  });
  
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      iconName: 'cart',
      titale: json['titale'] as String,
      date: DateTime.parse(json['date'] ?? DateTime.now()),
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      isExpenses: json['isExpenses'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconName': iconName,
      'titale': titale,
      'date': date.toIso8601String(),
      'amount': amount,
      'isExpenses': isExpenses ? 1 : 0,
    };
  }
}