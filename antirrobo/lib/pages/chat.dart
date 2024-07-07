import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(27, 41, 27, 509.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 371),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/image_2.png',
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    width: 359,
                    height: 97,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 102),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFF8189D1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                width: 456,
                padding: const EdgeInsets.fromLTRB(0, 14, 1.8, 8),
                child: Text(
                  'Activar protección',
                  style: GoogleFonts.getFont(
                    'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFF8189D1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                width: 456,
                padding: const EdgeInsets.fromLTRB(0, 14, 0.6, 8),
                child: Text(
                  'Desactivar protección',
                  style: GoogleFonts.getFont(
                    'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}