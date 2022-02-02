import 'package:flutter/material.dart';
import 'package:todoapp/model/room.dart';
import 'package:todoapp/pages/help.dart';
import 'package:todoapp/pages/room.dart';
import 'pages/home.dart';
import 'pages/setting.dart';
import 'pages/status_privacy.dart';
import 'pages/linked_device.dart';
import 'pages/starred_message.dart';
import 'pages/address_book.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const TabSwitch());
      // case '/second':
      //   // Validation of correct data type
      //   if (args is String) {
      //     return MaterialPageRoute(
      //       builder: (_) => SecondPage(
      //             data: args,
      //           ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();

      case '/linked_device':
        return MaterialPageRoute(builder: (_) => const LinkedDevice());
      case '/starred_message':
        return MaterialPageRoute(builder: (_) => const StarredMessage());
      case '/status_privacy':
        return MaterialPageRoute(builder: (_) => const StatusPrivacy());
      case '/setting':
        return MaterialPageRoute(builder: (_) => const Setting());
      case '/contact':
        return MaterialPageRoute(builder: (_) => const AddressBook());
      case '/help':
        return MaterialPageRoute(builder: (_) => const Help());
      case '/room':
        if (args is Room) {
          return MaterialPageRoute(builder: (_) => ChatRoom(room: args));
        }
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
