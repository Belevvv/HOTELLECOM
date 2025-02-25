import 'package:flutter/material.dart';
import 'dart:io'; 

class SettingsPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  const SettingsPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Тёмная тема'),
            trailing: Switch(
              value: isDarkTheme,
              onChanged: (value) => toggleTheme(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('О приложении!'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              'Выход',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Выйти'),
                  content: const Text('Вы уверены, что хотите выйти из приложения?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () => exit(0),
                      child: const Text('Выйти'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
      ),
      body: const Center(
        child: Text(
          'Приложение для бронирования отелей является отличным инструментом для путешественников, '
          'позволяющим быстро и удобно находить подходящее жилье в любой точке мира.',
        ),
      ),
    );
  }
}