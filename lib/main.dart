import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://siperindo.id'));
  }

  // Fungsi untuk menangani tombol back
  Future<bool> _onWillPop() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false; // Jangan keluar dari aplikasi, cukup kembali ke halaman sebelumnya
    }
    return true; // Keluar dari aplikasi
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Siperindo'),
        ),
        // Tambahkan Drawer (Sidebar Navigation)
        drawer: Builder(
          builder: (BuildContext context) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 254, 80, 0),
                    ),
                    child: const Text(
                      'Siperindo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context); // Menutup drawer
                      _controller.loadRequest(Uri.parse(
                          'https://siperindo.id')); // Muat halaman utama
                    },
                  ),
                  ExpansionTile(
                    leading: const Icon(Icons.add_home_outlined),
                    title: const Text('Bangun Rumah'),
                    children: <Widget>[
                      ListTile(
                        title: const Text('Tipe Mewah'),
                        onTap: () {
                          Navigator.pop(context); // Menutup drawer
                          _controller.loadRequest(Uri.parse(
                              'https://cekharga.siperindo.id/index.php/homerumah/mewah')); // Muat halaman "Desain Rumah"
                        },
                      ),
                      ListTile(
                        title: const Text('Tipe Ideal'),
                        onTap: () {
                          Navigator.pop(context); // Menutup drawer
                          _controller.loadRequest(Uri.parse(
                              'https://cekharga.siperindo.id/index.php/homerumah/bagus')); // Muat halaman "Estimasi Biaya"
                        },
                      ),
                      ListTile(
                        title: const Text('Tipe Murah'),
                        onTap: () {
                          Navigator.pop(context); // Menutup drawer
                          _controller.loadRequest(Uri.parse(
                              'https://cekharga.siperindo.id/index.php/homerumah/murah')); // Muat halaman "Jadwal Pembangunan"
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading: const Icon(Icons.balcony),
                    title: const Text('Bikin Interior'),
                    children: <Widget>[
                      ListTile(
                        title: const Text('Grade A'),
                        onTap: () {
                          Navigator.pop(context); // Menutup drawer
                          _controller.loadRequest(Uri.parse(
                              'https://cekharga.siperindo.id/index.php/interior')); // Muat halaman "Desain Rumah"
                        },
                      ),
                      ListTile(
                        title: const Text('Grade B'),
                        onTap: () {
                          Navigator.pop(context); // Menutup drawer
                          _controller.loadRequest(Uri.parse(
                              'https://cekharga.siperindo.id/index.php/interior_b')); // Muat halaman "Estimasi Biaya"
                        },
                      ),
                      ListTile(
                        title: const Text('Pake Murah'),
                        onTap: () {
                          Navigator.pop(context); // Menutup drawer
                          _controller.loadRequest(Uri.parse(
                              'https://cekharga.siperindo.id/index.php/interior_c')); // Muat halaman "Jadwal Pembangunan"
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Keluar Aplikasi'),
                    onTap: () {
                      Navigator.pop(context); // Menutup drawer
                      SystemNavigator.pop(); // Keluar dari aplikasi
                    },
                  ),
                ],
              ),
            );
          },
        ),
        body: WillPopScope(
          onWillPop: _onWillPop, // Menangani tombol back
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
