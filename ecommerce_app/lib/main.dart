import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/cart_controller.dart';
import 'controllers/wishlist_controller.dart';
import 'utils/theme_provider.dart';
import 'views/cart_screen.dart';
import 'views/home_screen.dart';
import 'views/wishlist_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => WishlistController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cartController = Provider.of<CartController>(context);
    final wishlistController = Provider.of<WishlistController>(context);
    
    return MaterialApp(
      title: 'Fashion Store',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(
          cartController: cartController,
          wishlistController: wishlistController,
        ),
        '/cart': (context) => CartScreen(
          cartController: cartController,
        ),
        '/wishlist': (context) => WishlistScreen(
          cartController: cartController,
          wishlistController: wishlistController,
        ),
      },
    );
  }
}
