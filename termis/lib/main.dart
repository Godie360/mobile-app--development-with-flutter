import 'package:flutter/material.dart';
import 'package:termis/components/home_screen.dart';
import 'package:termis/components/picture_screen.dart';
import 'package:termis/components/receipt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 210, 219)),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int screenIndex = 0;

  List<Widget> widgetList = const [
    Home(),
    Picture(),
    ReceiptGenerator(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 198, 210, 219),
          title: const Text('Termis app'),
          centerTitle: true,
        ),
        body: Center(
          child: widgetList[screenIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          onTap: (index) {
            setState(() {
              screenIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 198, 210, 219),
          iconSize: 30,
          selectedItemColor:
              Colors.black, // Set the text color for selected item
          unselectedItemColor: const Color.fromARGB(255, 153, 152, 152),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_repair),
              label: 'P/Details',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Receipt',
            ),
          ],
        ));
  }
}
