import 'package:flutter/material.dart';
import 'package:money_management_app/config/size_config.dart';

import 'home_screen.dart';
import 'list_view_screen.dart';

class LanchScreen extends StatelessWidget {
  const LanchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Wallet illustration inside circle ──────────────────────
              Expanded(
                flex: 5,
                child: Center(
                  child: Container(
                    width: SizeConfig.blockWidth * 65,
                    height: SizeConfig.blockWidth * 65,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEEEDF8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.blockWidth * 8),
                      child: Image.asset(
                        'assets/img/wallet.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Text content ───────────────────────────────────────────
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Save your money\nwith Expense Tracker',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.blockWidth * 6.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2D3A),
                        height: 1.35,
                      ),
                    ),

                    SizedBox(height: SizeConfig.blockHeight * 2),

                    // Subtitle
                    Text(
                      'The more your money works for you,\n'
                          'the less you have to work for money.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.blockWidth * 3.8,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFAAABB8),
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Button ─────────────────────────────────────────────────
              Expanded(
                flex: 2,
                child: Center(
                  child: SizedBox(
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
                          // Navigator.push(context, MaterialPageRoute(builder: ( context ) => HomeScreen()));
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: ( context ) => HomeScreen()));
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          "Let's Start",
                          style: TextStyle(
                            fontSize: SizeConfig.blockWidth * 4.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}