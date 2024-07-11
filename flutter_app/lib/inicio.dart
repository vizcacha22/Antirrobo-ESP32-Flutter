import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController confianzaNombreController = TextEditingController();
  final TextEditingController confianzaEmailController = TextEditingController();

  bool isButtonEnabled = false;

  Future<void> guardarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', nombreController.text);
    await prefs.setString('confianzaNombre', confianzaNombreController.text);
    await prefs.setString('confianzaEmail', confianzaEmailController.text);
  }

  void _checkFields() {
    setState(() {
      isButtonEnabled = nombreController.text.isNotEmpty &&
                       confianzaNombreController.text.isNotEmpty &&
                       confianzaEmailController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nombreController.addListener(_checkFields);
    confianzaNombreController.addListener(_checkFields);
    confianzaEmailController.addListener(_checkFields);
  }

  @override
  void dispose() {
    nombreController.dispose();
    confianzaNombreController.dispose();
    confianzaEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset('assets/images/image_1.png'), 
              ),
              const SizedBox(height: 8),
              const Text(
                'Protege tu celular',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  hintText: 'Ingrese su nombre',
                  filled: true,
                  fillColor: Colors.pink[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confianzaNombreController,
                decoration: InputDecoration(
                  hintText: 'Ingrese nombre de persona de confianza',
                  filled: true,
                  fillColor: Colors.pink[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confianzaEmailController,
                decoration: InputDecoration(
                  hintText: 'Ingrese correo electrónico de persona de confianza',
                  filled: true,
                  fillColor: Colors.pink[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () async {
                        await guardarDatos();
                        Navigator.pushNamed(context, '/protection');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}