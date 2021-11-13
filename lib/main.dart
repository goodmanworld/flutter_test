import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/auth_screen.dart';
import './screens/map_screen.dart';
import './screens/splash_screen.dart';

import './providers/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ChangeNotifierProxyProvider<Auth, Products>(
        //   create: (ctx) =>
        //       Products(null as String, null as String, null as List<Product>),
        //   update: (ctx, auth, previousProducts) => Products(
        //     auth.token as String,
        //     auth.userId as String,
        //     previousProducts == null ? [] : previousProducts.items,
        //   ),
        // ),
        // ChangeNotifierProvider.value(
        //   value: Cart(),
        // ),
        // ChangeNotifierProxyProvider<Auth, Orders>(
        //   create: (ctx) =>
        //       Orders(null as String, null as String, null as List<OrderItem>),
        //   update: (ctx, auth, previousOrders) => Orders(
        //     auth.token as String,
        //     auth.userId as String,
        //     previousOrders == null ? [] : previousOrders.orders,
        //   ),
        // ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            // pageTransitionsTheme: PageTransitionsTheme(
            //   builders: {
            //     TargetPlatform.android: CustomPageTransitionBuilder(),
            //     TargetPlatform.iOS: CustomPageTransitionBuilder(),
            //   },
            // ),
          ),
          home: auth.isAuth
              ? MapScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            MapScreen.routeName: (ctx) => MapScreen(),
            // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            // CartScreen.routeName: (ctx) => CartScreen(),
            // OrdersScreen.routeName: (ctx) => OrdersScreen(),
            // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            // EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
