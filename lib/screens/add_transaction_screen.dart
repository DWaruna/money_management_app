import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management_app/config/size_config.dart';
import 'package:money_management_app/screens/tranceaction_success_screen.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isExpense = true;
  String _amount = '0.00';
  String _selectedCategory = 'Shopping';
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Shopping', 'icon': Icons.shopping_bag_outlined, 'color': const Color(0xFFFF6B6B)},
    {'label': 'Food', 'icon': Icons.restaurant_outlined, 'color': const Color(0xFFFFB347)},
    {'label': 'Transport', 'icon': Icons.directions_car_outlined, 'color': const Color(0xFF4FC3F7)},
    {'label': 'Health', 'icon': Icons.favorite_outline, 'color': const Color(0xFFEF5350)},
    {'label': 'Entertainment', 'icon': Icons.movie_outlined, 'color': const Color(0xFF7B6FE8)},
    {'label': 'Salary', 'icon': Icons.account_balance_wallet_outlined, 'color': const Color(0xFF27AE60)},
    {'label': 'Freelance', 'icon': Icons.laptop_outlined, 'color': const Color(0xFF26C6DA)},
    {'label': 'Other', 'icon': Icons.category_outlined, 'color': const Color(0xFFBDBDBD)},
  ];

  void _appendDigit(String digit) {
    setState(() {
      if (_amount == '0.00') {
        _amount = digit + '.00';
      } else {
        final withoutDecimal = _amount.replaceAll('.00', '');
        _amount = withoutDecimal + digit + '.00';
      }
    });
  }

  void _deleteDigit() {
    setState(() {
      final withoutDecimal = _amount.replaceAll('.00', '');
      if (withoutDecimal.length <= 1) {
        _amount = '0.00';
      } else {
        _amount = withoutDecimal.substring(0, withoutDecimal.length - 1) + '.00';
      }
    });
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4.8,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E),
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 2),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: _categories.length,
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final isSelected = _selectedCategory == cat['label'];
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = cat['label'] as String);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: SizeConfig.blockWidth * 14,
                        height: SizeConfig.blockWidth * 14,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (cat['color'] as Color).withOpacity(0.15)
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(14),
                          border: isSelected
                              ? Border.all(color: cat['color'] as Color, width: 2)
                              : null,
                        ),
                        child: Icon(
                          cat['icon'] as IconData,
                          color: cat['color'] as Color,
                          size: SizeConfig.blockWidth * 6.5,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockHeight * 0.5),
                      Text(
                        cat['label'] as String,
                        style: TextStyle(
                          fontSize: SizeConfig.blockWidth * 2.8,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? cat['color'] as Color
                              : const Color(0xFF555555),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: SizeConfig.blockHeight * 2),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final selectedCat = _categories.firstWhere(
          (c) => c['label'] == _selectedCategory,
      orElse: () => _categories[0],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ────────────────────────────────────────────────
            _buildAppBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.blockHeight * 2.5),

                    // ── Toggle ─────────────────────────────────────────
                    _buildToggle(),

                    SizedBox(height: SizeConfig.blockHeight * 2.5),

                    // ── Amount ─────────────────────────────────────────
                    _buildAmountCard(),

                    SizedBox(height: SizeConfig.blockHeight * 3),

                    // ── Category ───────────────────────────────────────
                    _buildLabel('Category'),
                    SizedBox(height: SizeConfig.blockHeight * 1),
                    _buildCategoryDropdown(selectedCat),

                    SizedBox(height: SizeConfig.blockHeight * 3),

                    // ── Note ───────────────────────────────────────────
                    _buildLabel('Note'),
                    SizedBox(height: SizeConfig.blockHeight * 1),
                    _buildNoteField(),

                    SizedBox(height: SizeConfig.blockHeight * 4),

                    // ── Submit Button ──────────────────────────────────
                    _buildSubmitButton(),

                    SizedBox(height: SizeConfig.blockHeight * 3),
                  ],
                ),
              ),
            ),

            // ── Bottom Nav ─────────────────────────────────────────────
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
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
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
                  Icons.chevron_left,
                  size: SizeConfig.blockWidth * 6,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ),
          ),
          Text(
            'Add Transaction',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 4.8,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }

  // ── Toggle ───────────────────────────────────────────────────────────────
  Widget _buildToggle() {
    return Center(
      child: Container(
        height: SizeConfig.blockHeight * 6,
        padding: EdgeInsets.all(SizeConfig.blockWidth * 1.2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToggleOption(
              label: 'Expense',
              isSelected: _isExpense,
              onTap: () => setState(() => _isExpense = true),
            ),
            SizedBox(width: SizeConfig.blockWidth * 1),
            _ToggleOption(
              label: 'Income',
              isSelected: !_isExpense,
              onTap: () => setState(() => _isExpense = false),
            ),
          ],
        ),
      ),
    );
  }

  // ── Amount Card ──────────────────────────────────────────────────────────
  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockHeight * 2.5,
        horizontal: SizeConfig.blockWidth * 5,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\$$_amount',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 10,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF1A1A2E),
              letterSpacing: -1,
            ),
          ),
          SizedBox(width: SizeConfig.blockWidth * 2),
          // Backspace button
          GestureDetector(
            onTap: _deleteDigit,
            child: Icon(
              Icons.backspace_outlined,
              size: SizeConfig.blockWidth * 5.5,
              color: const Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }

  // ── Category Dropdown ────────────────────────────────────────────────────
  Widget _buildCategoryDropdown(Map<String, dynamic> selectedCat) {
    return GestureDetector(
      onTap: _showCategoryPicker,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 4,
          vertical: SizeConfig.blockHeight * 1.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Category icon
            Container(
              width: SizeConfig.blockWidth * 10,
              height: SizeConfig.blockWidth * 10,
              decoration: BoxDecoration(
                color: (selectedCat['color'] as Color).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                selectedCat['icon'] as IconData,
                color: selectedCat['color'] as Color,
                size: SizeConfig.blockWidth * 5.5,
              ),
            ),
            SizedBox(width: SizeConfig.blockWidth * 3),
            Expanded(
              child: Text(
                _selectedCategory,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 4.2,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF888888),
              size: SizeConfig.blockWidth * 6,
            ),
          ],
        ),
      ),
    );
  }

  // ── Note Field ───────────────────────────────────────────────────────────
  Widget _buildNoteField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _noteController,
        maxLines: 4,
        style: TextStyle(
          fontSize: SizeConfig.blockWidth * 4,
          color: const Color(0xFF1A1A2E),
        ),
        decoration: InputDecoration(
          hintText: 'Note (optional)',
          hintStyle: TextStyle(
            color: const Color(0xFFBBBBBB),
            fontSize: SizeConfig.blockWidth * 4,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(SizeConfig.blockWidth * 4),
        ),
      ),
    );
  }

  // ── Label ────────────────────────────────────────────────────────────────
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: SizeConfig.blockWidth * 4.5,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1A1A2E),
      ),
    );
  }

  // ── Submit Button ────────────────────────────────────────────────────────
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.blockHeight * 7,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9B7FEA), Color(0xFF7047D1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7047D1).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ( context ) => TranceactionSuccessScreen()),
                ( route ) => route.isFirst);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            _isExpense ? 'Add Expense' : 'Add Income',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 4.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
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

          // FAB center
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
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: SizeConfig.blockWidth * 7,
            ),
          ),

          _NavItem(icon: Icons.credit_card_outlined, isActive: false, onTap: () {}),
          _NavItem(icon: Icons.person_outline, isActive: false, onTap: () {}),
        ],
      ),
    );
  }
}

// ── Toggle Option ─────────────────────────────────────────────────────────────
class _ToggleOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleOption({
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
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 7,
          vertical: SizeConfig.blockHeight * 1,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
            colors: [Color(0xFFFF6B8A), Color(0xFFD94F7A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Container(
                width: SizeConfig.blockWidth * 2,
                height: SizeConfig.blockWidth * 2,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 1.5),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF888888),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Nav Item ──────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

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