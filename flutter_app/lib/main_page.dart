import 'dart:convert';
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';
import 'package:safezone/widgets/action_button.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' as fln;
import 'package:telephony/telephony.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _bluetooth = FlutterBluetoothSerial.instance;
  final Telephony telephony = Telephony.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  int times = 0;
  bool isProtectionOn = false;
  String userName = '';
  String trustedPersonName = '';
  String trustedPersonEmail = '';
  fln.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = fln.FlutterLocalNotificationsPlugin();

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  void _receiveData() {
    _connection?.input?.listen((event) {
      if (String.fromCharCodes(event) == "p") {
        setState(() => times = times + 1);
      }
    });
  }

  void _sendData(String data) {
    if (_connection?.isConnected ?? false) {
      _connection?.output.add(ascii.encode(data));
    }
  }

Future<void> _loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    userName = prefs.getString('nombre') ?? '';
    trustedPersonName = prefs.getString('confianzaNombre') ?? '';
    trustedPersonEmail = prefs.getString('confianzaEmail') ?? '';
  });
}
  @override
  void initState() {
    super.initState();

    if (!Platform.isAndroid) {
      _showPlatformError();
      return;
    }

    _loadUserData();

    var initializationSettingsAndroid = fln.AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = fln.InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          break;
      }
    });

    // Solicitar permisos de SMS
    _requestSmsPermission();
  }

  Future<void> _requestSmsPermission() async {
    final bool? result = await telephony.requestSmsPermissions;
    if (result == null || !result) {
      _showPlatformError("Permisos de SMS no concedidos");
    }
  }

  void _showPlatformError([String message = "Esta aplicación solo funciona en Android."]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                exit(0); // Cierra la aplicación
              },
            ),
          ],
        );
      },
    );
  }

  void _startProtection() async {
  setState(() {
    isProtectionOn = true;
  });
  print("Protección activada");
  _showNotification('Protección activada', 'La protección contra robos está activada.');

  while (isProtectionOn) {
    if (!_bluetoothState) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      String message = 'Hola $trustedPersonName, se te notifica que el celular de $userName ha sido robado, se ubica en estos momentos en $googleMapsUrl. Este mensaje se enviará cada minuto hasta que se pulse el botón apagar.';

      print(googleMapsUrl);
      print(message);

      // Datos de la cuenta de correo
      String username = 'timmyprotection@gmail.com'; // Tu dirección de correo
      String password = 'qmmv qwwq ipcx jfhz'; // Contraseña de la aplicación generada

      final smtpServer = gmail(username, password);

      final emailMessage = Message()
        ..from = Address(username, 'Tu Nombre')
        ..recipients.add(trustedPersonEmail)
        ..subject = 'Alerta de robo de celular'
        ..text = message;

      try {
        final sendReport = await send(emailMessage, smtpServer);
        print('Correo enviado con éxito: ' + sendReport.toString());
        _showNotification('Correo enviado', 'El correo ha sido enviado al contacto de confianza.');
      } catch (e) {
        print('Error al enviar correo: $e');
      }

      await Future.delayed(Duration(minutes: 1));
    }
    await Future.delayed(Duration(seconds: 10)); // Check every 10 seconds if Bluetooth is disconnected
  }
}
  void _stopProtection() {
    setState(() {
      isProtectionOn = false;
      print("Protección desactivada");
    });
    _showNotification('Protección desactivada', 'La protección contra robos está desactivada.');
  }

  void _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = fln.AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: fln.Importance.max, priority: fln.Priority.high, ticker: 'ticker');
    var platformChannelSpecifics = fln.NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isAndroid) {
      return Scaffold(
        body: Center(
          child: Text("Esta aplicación solo funciona en Android."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SAFEZONE'),
      ),
      body: Column(
        children: [
          _controlBT(),
          _infoDevice(),
          Expanded(child: _listDevices()),
          _buttons(),
        ],
      ),
    );
  }

  Widget _controlBT() {
    return SwitchListTile(
      value: _bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await _bluetooth.requestEnable();
        } else {
          await _bluetooth.requestDisable();
        }
      },
      tileColor: Colors.black26,
      title: Text(
        _bluetoothState ? "Bluetooth encendido" : "Bluetooth apagado",
      ),
    );
  }

  Widget _infoDevice() {
    return ListTile(
      tileColor: Colors.black12,
      title: Text("Conectado a: ${_deviceConnected?.name ?? "ninguno"}"),
      trailing: _connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("Desconectar"),
            )
          : TextButton(
              onPressed: _getDevices,
              child: const Text("Ver dispositivos"),
            ),
    );
  }

  Widget _listDevices() {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in _devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('conectar'),
                          onPressed: () async {
                            setState(() => _isConnecting = true);

                            _connection = await BluetoothConnection.toAddress(device.address);
                            _deviceConnected = device;
                            _devices = [];
                            _isConnecting = false;

                            _receiveData();

                            setState(() {});
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }

  Widget _buttons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
      color: Colors.black12,
      child: Column(
        children: [
          const Text('Protección contra robos', style: TextStyle(fontSize: 18.0)),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  text: "Encender",
                  color: Colors.green,
                  onTap: () => _startProtection(),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ActionButton(
                  color: Colors.red,
                  text: "Apagar",
                  onTap: () => _stopProtection(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}