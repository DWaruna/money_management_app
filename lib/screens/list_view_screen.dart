import 'package:flutter/material.dart';
import 'package:money_management_app/config/size_config.dart';

import 'add_transaction_screen.dart';
import 'all_tanceaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentMonthIndex = 2; // March = index 2

  final List<String> _months = [
    'January 2024',
    'February 2024',
    'March 2024',
    'April 2024',
    'May 2024',
  ];

  final List<Transaction> _transactions = [
    Transaction(
      icon: Icons.shopping_cart_outlined,
      iconBg: const Color(0xFFF3F3F3),
      iconColor: const Color(0xFF555555),
      title: 'Groceries',
      subtitle: 'Today',
      amount: -120.00,
    ),
    Transaction(
      iconAsset: 'assets/img/paypal.png',
      iconBg: const Color(0xFF003087),
      title: 'Salary',
      subtitle: 'Mar 25',
      amount: 2000.00,
    ),
    Transaction(
      iconAsset: 'assets/img/uber.png',
      iconBg: const Color(0xFF1A1A1A),
      title: 'Uber',
      subtitle: 'Mar 24',
      amount: -35.00,
    ),
    Transaction(
      iconAsset: 'assets/img/store.png',
      iconBg: const Color(0xFFCC0000),
      title: 'Online Store',
      subtitle: 'Mar 20',
      amount: -150.00,
    ),
    Transaction(
      icon: Icons.account_balance_outlined,
      iconBg: const Color(0xFFF3F3F3),
      iconColor: const Color(0xFF555555),
      title: 'Bank Transfer',
      subtitle: 'Mar 18',
      amount: -100.00,
    ),
    Transaction(
      icon: Icons.local_hospital_outlined,
      iconBg: const Color(0xFFFFEEEE),
      iconColor: const Color(0xFFCC0000),
      title: 'Healthcare',
      subtitle: 'Mar 15',
      amount: -200.00,
    ),
  ];

  void _previousMonth() {
    if (_currentMonthIndex > 0) {
      setState(() => _currentMonthIndex--);
    }
  }

  void _nextMonth() {
    if (_currentMonthIndex < _months.length - 1) {
      setState(() => _currentMonthIndex++);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            // ── Month Selector ─────────────────────────────────────────
            _buildMonthSelector(),

            // ── Fixed: Balance Card ──────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockHeight * 2),
                  _buildBalanceCard(),
                  SizedBox(height: SizeConfig.blockHeight * 3),
                  _buildSectionHeader(),
                  SizedBox(height: SizeConfig.blockHeight * 1.5),
                ],
              ),
            ),

            // ── Scrollable: Transaction List ─────────────────────────
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 5,
                ),
                child: _buildTransactionList(),
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 10),
          ],
        ),
      ),
    );
  }

  // ── Month Selector ───────────────────────────────────────────────────────
  Widget _buildMonthSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 1.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left arrow
          _ArrowButton(
            icon: Icons.chevron_left,
            onTap: _previousMonth,
          ),

          // Month + year
          Row(
            children: [
              Text(
                _months[_currentMonthIndex],
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 4.8,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 1),
              Icon(
                Icons.chevron_right,
                size: SizeConfig.blockWidth * 4,
                color: const Color(0xFF888888),
              ),
            ],
          ),

          // Right arrow
          _ArrowButton(
            icon: Icons.chevron_right,
            onTap: _nextMonth,
          ),
        ],
      ),
    );
  }

  // ── Balance Card ─────────────────────────────────────────────────────────
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.blockWidth * 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF9B59B6),
            Color(0xFF7D3C98),
            Color(0xFFE74C6E),
            Color(0xFFF39C5A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9B59B6).withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: SizeConfig.blockWidth * 3.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.white.withOpacity(0.85),
                size: SizeConfig.blockWidth * 6,
              ),
            ],
          ),

          SizedBox(height: SizeConfig.blockHeight * 1),

          // Balance amount
          Text(
            '\$3,550.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.blockWidth * 9,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),

          SizedBox(height: SizeConfig.blockHeight * 2.5),

          // Income / Expense row
          Row(
            children: [
              _buildBalanceStat(
                label: 'Income',
                amount: '\$2,500',
                icon: Icons.arrow_downward_rounded,
                iconBg: const Color(0xFF27AE60),
              ),
              SizedBox(width: SizeConfig.blockWidth * 12),
              _buildBalanceStat(
                label: 'Expense',
                amount: '\$950',
                icon: Icons.arrow_upward_rounded,
                iconBg: Colors.white.withOpacity(0.25),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceStat({
    required String label,
    required String amount,
    required IconData icon,
    required Color iconBg,
  }) {
    return Row(
      children: [
        Container(
          width: SizeConfig.blockWidth * 8,
          height: SizeConfig.blockWidth * 8,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: SizeConfig.blockWidth * 4.5,
          ),
        ),
        SizedBox(width: SizeConfig.blockWidth * 2.5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: SizeConfig.blockWidth * 3.3,
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 0.3),
            Text(
              amount,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockWidth * 4.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Section Header ───────────────────────────────────────────────────────
  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Transactions',
          style: TextStyle(
            fontSize: SizeConfig.blockWidth * 4.8,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: ( context ) => TransactionsScreen()));
          },
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 3.8,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF7B6FE8),
            ),
          ),
        ),
      ],
    );
  }

  // ── Transaction List ─────────────────────────────────────────────────────
  Widget _buildTransactionList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: _transactions.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: const Color(0xFFF0F0F0),
          indent: SizeConfig.blockWidth * 18,
        ),
        itemBuilder: (context, index) {
          return _TransactionTile(transaction: _transactions[index]);
        },
      ),
    );
  }

  // ── FAB ──────────────────────────────────────────────────────────────────
  Widget _buildFAB() {
    return Container(
      width: SizeConfig.blockWidth * 15,
      height: SizeConfig.blockWidth * 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF9B7FEA), Color(0xFF7047D1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7047D1).withOpacity(0.45),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: ( context ) => AddTransactionScreen()));},
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: SizeConfig.blockWidth * 8,
        ),
      ),
    );
  }
}

// ── Arrow Button ─────────────────────────────────────────────────────────────
class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.blockWidth * 9,
        height: SizeConfig.blockWidth * 9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: SizeConfig.blockWidth * 5.5,
          color: const Color(0xFF1A1A2E),
        ),
      ),
    );
  }
}

// ── Transaction Model ─────────────────────────────────────────────────────────
class Transaction {
  final IconData? icon;
  final String? iconAsset;
  final Color iconBg;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final double amount;

  Transaction({
    this.icon,
    this.iconAsset,
    required this.iconBg,
    this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
  });
}

// ── Transaction Tile ──────────────────────────────────────────────────────────
class _TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.amount > 0;
    final amountText = isIncome
        ? '+\$${transaction.amount.toStringAsFixed(2)}'
        : '-\$${transaction.amount.abs().toStringAsFixed(2)}';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 1.6,
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: SizeConfig.blockWidth * 12,
            height: SizeConfig.blockWidth * 12,
            decoration: BoxDecoration(
              color: transaction.iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: transaction.iconAsset != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                transaction.iconAsset!,
                fit: BoxFit.cover,
              ),
            )
                : Icon(
              transaction.icon,
              color: transaction.iconColor ?? Colors.white,
              size: SizeConfig.blockWidth * 6,
            ),
          ),

          SizedBox(width: SizeConfig.blockWidth * 4),

          // Title & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 4,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight * 0.4),
                Text(
                  transaction.subtitle,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 3.3,
                    color: const Color(0xFFAAAAAA),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amountText,
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 4,
              fontWeight: FontWeight.w700,
              color: isIncome
                  ? const Color(0xFF27AE60)
                  : const Color(0xFFE74C3C),
            ),
          ),
        ],
      ),
    );
  }
}