// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/pages/usuarios_page.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(
              child: Text('Loading...'),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final autService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await autService.isLoggedIn();

    if (autenticado) {
      socketService.connect();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => UsuariosPage()),
      );
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
