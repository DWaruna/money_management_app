import 'package:flutter/material.dart';
import 'package:money_management_app/config/size_config.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  int _currentMonthIndex = 3; // April = index 3
  String _selectedFilter = 'All';

  final List<String> _months = [
    'January 2024', 'February 2024', 'March 2024',
    'April 2024', 'May 2024', 'June 2024',
  ];

  final List<String> _filters = ['All', 'Income', 'Expense'];

  final List<TransactionItem> _allTransactions = [
    TransactionItem(
      icon: Icons.shopping_bag_outlined,
      iconBg: const Color(0xFFFFEEEE),
      iconColor: const Color(0xFFE74C3C),
      title: 'Online Store',
      time: '12:45 PM',
      dateGroup: 'Today, April 27',
      amount: -75.00,
      type: 'expense',
    ),
    TransactionItem(
      iconAsset: 'assets/img/paypal.png',
      iconBg: const Color(0xFF003087),
      title: 'Uber',
      time: '9:20 AM',
      dateGroup: 'Today, April 27',
      amount: 15.00,
      type: 'income',
    ),
    TransactionItem(
      icon: Icons.laptop_outlined,
      iconBg: const Color(0xFFEEE8FF),
      iconColor: const Color(0xFF7047D1),
      title: 'Freelance',
      time: '6:30 PM',
      dateGroup: 'Yesterday, April 26',
      amount: 900.00,
      type: 'income',
    ),
    TransactionItem(
      icon: Icons.restaurant_outlined,
      iconBg: const Color(0xFFFFF3E0),
      iconColor: const Color(0xFFFF8C00),
      title: 'Dinner',
      time: '7:46 PM',
      dateGroup: 'Yesterday, April 26',
      amount: -50.00,
      type: 'expense',
    ),
    TransactionItem(
      icon: Icons.shopping_cart_outlined,
      iconBg: const Color(0xFFF3F3F3),
      iconColor: const Color(0xFF555555),
      title: 'Groceries',
      time: 'Mar 20',
      dateGroup: 'Yesterday, April 26',
      amount: -120.00,
      type: 'expense',
    ),
    TransactionItem(
      icon: Icons.shopping_bag_outlined,
      iconBg: const Color(0xFFFFEEEE),
      iconColor: const Color(0xFFE74C3C),
      title: 'Groceries',
      time: 'Mar 20',
      dateGroup: 'April 25, 2024',
      amount: -15.00,
      type: 'expense',
    ),
    TransactionItem(
      icon: Icons.account_balance_outlined,
      iconBg: const Color(0xFFE8F5E9),
      iconColor: const Color(0xFF27AE60),
      title: 'Bank Transfer',
      time: '10:00 AM',
      dateGroup: 'April 25, 2024',
      amount: 500.00,
      type: 'income',
    ),
    TransactionItem(
      icon: Icons.directions_car_outlined,
      iconBg: const Color(0xFFE3F2FD),
      iconColor: const Color(0xFF1E88E5),
      title: 'Transport',
      time: '8:15 AM',
      dateGroup: 'April 25, 2024',
      amount: -20.00,
      type: 'expense',
    ),
    TransactionItem(
      icon: Icons.local_cafe_outlined,
      iconBg: const Color(0xFFFFF3E0),
      iconColor: const Color(0xFFFF8C00),
      title: 'Coffee',
      time: 'Mar 18',
      dateGroup: 'April 24, 2024',
      amount: -5.00,
      type: 'expense',
    ),
  ];

  List<TransactionItem> get _filtered {
    if (_selectedFilter == 'All') return _allTransactions;
    return _allTransactions
        .where((t) => t.type == _selectedFilter.toLowerCase())
        .toList();
  }

  // Group transactions by dateGroup
  Map<String, List<TransactionItem>> get _grouped {
    final map = <String, List<TransactionItem>>{};
    for (final t in _filtered) {
      map.putIfAbsent(t.dateGroup, () => []).add(t);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final grouped = _grouped;
    final groups = grouped.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────────────────
            _buildAppBar(),

            // ── Filter Tabs ──────────────────────────────────────────
            _buildFilterTabs(),

            SizedBox(height: SizeConfig.blockHeight * 1.5),

            // ── Transaction Groups ───────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 5,
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  final items = grouped[group]!;
                  return _buildGroup(group, items);
                },
              ),
            ),

            // ── Bottom Nav ───────────────────────────────────────────
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 1.5,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: _IconBtn(
              icon: Icons.chevron_left,
              onTap: () => Navigator.pop(context),
            ),
          ),

          // Title
          Text(
            'Transactions',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 4.8,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),

          // Forward button
          Align(
            alignment: Alignment.centerRight,
            child: _IconBtn(
              icon: Icons.chevron_right,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  // ── Filter Tabs ──────────────────────────────────────────────────────────
  Widget _buildFilterTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
      child: Row(
        children: [
          // Month chip
          _MonthChip(label: _months[_currentMonthIndex].split(' ')[0] +
              ' ' + _months[_currentMonthIndex].split(' ')[1]),

          SizedBox(width: SizeConfig.blockWidth * 2),

          // Filter chips
          ..._filters.map((f) => Padding(
            padding: EdgeInsets.only(right: SizeConfig.blockWidth * 2),
            child: _FilterChip(
              label: f,
              isSelected: _selectedFilter == f,
              onTap: () => setState(() => _selectedFilter = f),
            ),
          )),
        ],
      ),
    );
  }

  // ── Group ────────────────────────────────────────────────────────────────
  Widget _buildGroup(String title, List<TransactionItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.blockHeight * 2.5),

        // Date label
        Text(
          title,
          style: TextStyle(
            fontSize: SizeConfig.blockWidth * 4.2,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A2E),
          ),
        ),

        SizedBox(height: SizeConfig.blockHeight * 1.2),

        // Items card
        Container(
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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: const Color(0xFFF0F0F0),
              indent: SizeConfig.blockWidth * 18,
            ),
            itemBuilder: (_, i) => _TransactionTile(item: items[i]),
          ),
        ),
      ],
    );
  }

  // ── Bottom Nav ───────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 6,
        vertical: SizeConfig.blockHeight * 1.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(icon: Icons.home_outlined, isActive: false, onTap: () {}),
          _NavItem(icon: Icons.bar_chart_outlined, isActive: false, onTap: () {}),

          // FAB
          Container(
            width: SizeConfig.blockWidth * 14,
            height: SizeConfig.blockWidth * 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF9B7FEA), Color(0xFF7047D1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7047D1).withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(Icons.add, color: Colors.white, size: SizeConfig.blockWidth * 7),
          ),

          _NavItem(icon: Icons.credit_card_outlined, isActive: false, onTap: () {}),
          _NavItem(icon: Icons.person_outline, isActive: false, onTap: () {}),
        ],
      ),
    );
  }
}

// ── Transaction Item Model ────────────────────────────────────────────────────
class TransactionItem {
  final IconData? icon;
  final String? iconAsset;
  final Color iconBg;
  final Color? iconColor;
  final String title;
  final String time;
  final String dateGroup;
  final double amount;
  final String type; // 'income' | 'expense'

  TransactionItem({
    this.icon,
    this.iconAsset,
    required this.iconBg,
    this.iconColor,
    required this.title,
    required this.time,
    required this.dateGroup,
    required this.amount,
    required this.type,
  });
}

// ── Transaction Tile ──────────────────────────────────────────────────────────
class _TransactionTile extends StatelessWidget {
  final TransactionItem item;
  const _TransactionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final isIncome = item.amount > 0;
    final amountStr = isIncome
        ? '+\$${item.amount.toStringAsFixed(2)}'
        : '-\$${item.amount.abs().toStringAsFixed(2)}';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 1.6,
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: SizeConfig.blockWidth * 12,
            height: SizeConfig.blockWidth * 12,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: item.iconAsset != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(item.iconAsset!, fit: BoxFit.cover),
            )
                : Icon(
              item.icon,
              color: item.iconColor ?? Colors.white,
              size: SizeConfig.blockWidth * 6,
            ),
          ),

          SizedBox(width: SizeConfig.blockWidth * 3.5),

          // Title & time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 4,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight * 0.4),
                Text(
                  item.time,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 3.3,
                    color: const Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amountStr,
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

// ── Month Chip ────────────────────────────────────────────────────────────────
class _MonthChip extends StatelessWidget {
  final String label;
  const _MonthChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 3.5,
        vertical: SizeConfig.blockHeight * 0.8,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8FA3), Color(0xFFD94F7A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.blockWidth * 3.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Filter Chip ───────────────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 4,
          vertical: SizeConfig.blockHeight * 0.8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7047D1) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: SizeConfig.blockWidth * 3.5,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF888888),
          ),
        ),
      ),
    );
  }
}

// ── Icon Button ───────────────────────────────────────────────────────────────
class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBtn({required this.icon, required this.onTap});

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
        child: Icon(icon, size: SizeConfig.blockWidth * 6, color: const Color(0xFF1A1A2E)),
      ),
    );
  }
}

// ── Nav Item ──────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: SizeConfig.blockWidth * 6.5,
        color: isActive ? const Color(0xFF7047D1) : const Color(0xFFBBBBBB),
      ),
    );
  }
}