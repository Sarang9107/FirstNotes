import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_actions.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Main UI'),
            backgroundColor: Colors.blue,
            actions: [
              PopupMenuButton<MenuAction>(
                onSelected: (value) async {
                  switch (value) {
                    case MenuAction.logout:
                      final shouldlogout = await showLogoutDialog(context);
                      if (shouldlogout) {
                        await AuthService.firebase().logOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (_) => false,
                        );
                      }
                  }
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                        value: MenuAction.logout, child: Text('Logout'))
                  ];
                },
              )
            ]),
        body: const Center(
          child: Text("Under Working...... \n jasti ghai asel tr swata kara!"),
        ),);
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancle')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Log out')),
            ]);
      }).then((value) => value ?? false);
}
