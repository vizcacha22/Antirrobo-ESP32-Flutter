import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 61, 36, 69.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 0, 49),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/image_1.png',
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 312,
                  height: 290,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6.5, 0, 0, 68),
              child: Text(
                'Protege tu celular',
                style: GoogleFonts.getFont(
                  'Josefin Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 48,
                  color: const Color(0xFF747373),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 83),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFEFDFDF),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24.3, 14, 24.3, 8),
                child: Text(
                  'Ingrese su nombre',
                  style: GoogleFonts.getFont(
                    'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: const Color(0xFFAFA1A1),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 49),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFEFDFDF),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 14, 24, 8),
                child: Text(
                  'Ingrese nombre de persona de confianza',
                  style: GoogleFonts.getFont(
                    'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: const Color(0xFFAFA1A1),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 70.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFEFDFDF),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x80000000),
                    offset: Offset(10, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 14, 24, 8),
                child: Text(
                  'Ingrese número de persona de confianza',
                  style: GoogleFonts.getFont(
                    'Mukta',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: const Color(0xFFAFA1A1),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(1, 0, 0, 142.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 4),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 1.5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xFFEFDFDF),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x80000000),
                            offset: Offset(10, 10),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const SizedBox(
                        width: 59,
                        height: 62,
                      ),
                    ),
                  ),
            Container(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18.9, 0),
                    child: Text(
                      '+',
                      style: GoogleFonts.getFont(
                        'Mukta',
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: const Color(0xFFAFA1A1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFBC7C7C),
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
                padding: const EdgeInsets.fromLTRB(0, 14, 2.8, 8),
                child: Text(
                  'Continuar',
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