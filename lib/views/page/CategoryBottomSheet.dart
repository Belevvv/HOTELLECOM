import 'package:flutter/material.dart';
import 'package:flutter_application_3/auth/authservice.dart';
import 'package:flutter_application_3/views/page/bookmarks_page.dart';
import 'package:flutter_application_3/views/page/profile_page.dart';
import 'package:flutter_application_3/views/page/settings_page.dart';
import 'package:heroicons/heroicons.dart';

class CategoryBottomSheet extends StatelessWidget {
  const CategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
 
    final userEmail = 'user@example.com'; 
    final userData = AuthService.instance.getUserData(userEmail);

    final categories = [
      {
        'icon': HeroIcons.home,
        'label': 'О приложении!',
        'route': const AboutAppPage(),
      },
      {
        'icon': HeroIcons.heart,
        'label': 'Избранное',
        'route': const BookmarksPage(),
      },
      {
        'icon': HeroIcons.user,
        'label': 'Профиль',
        'route': ProfilePage(
          email: userData?['email'] ?? 'Нет данных',
          nickname: userData?['nickname'] ?? 'Гость',
        ),
      },
      {
        'icon': HeroIcons.cog,
        'label': 'Настройки',
        'route': SettingsPage(
          toggleTheme: () {},
          isDarkTheme: false,
        ),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Категории',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          ListView.separated(
            shrinkWrap: true,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                leading: HeroIcon(category['icon'] as HeroIcons),
                title: Text(category['label'] as String),
                onTap: () {
                  if (category['route'] != null) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => category['route'] as Widget,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}