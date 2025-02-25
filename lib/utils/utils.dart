import 'package:flutter_application_3/models/hotel.dart';

import 'package:flutter/material.dart';


final $utils = Utils();


class Utils {

  late final primary = Colors.blueGrey;


  final hotels = <Hotel>[
    Hotel(
      name: 'Колледж связи №54 - 6',
      address: 'город Москва, Рязанский проспект, дом 8, строение 1',
      price: 666.0,
      star: 5.0,
      description: 'Рязанское - 6» Центр Автоматизации и ИТ',
      more: {
        'rooms': '2',
        'mq': '65',
        'location': 'Russia,Moscow',
        'url': 'assets/home/hotel_1.jpg',
        'details': ['assets/details/details_1.jpg', 'assets/details/details_2.jpg'],
      }
    ),
    Hotel(
        name: 'Колледж связи №54 - 7',
        address: 'город Москва, Рабочая улица, дом 12, строение 1',
        price: 5.0,
        star: 1.9,
        description: 'Римское - 7» Центр Радиоэлектроники',
        more: {
          'rooms': '4',
          'mq': '90',
          'location': 'Russia,Moscow',
          'url': 'assets/home/hotel_2.jpg',
          'details': ['assets/details/details_3.jpg', 'assets/details/details_4.jpg'],
        }
    ),
    Hotel(
        name: 'Колледж связи №54 - 8',
        address: 'город Москва, Басовская улица, дом 12',
        price: 55.0,
        star: 3.8,
        description: 'Авиамоторное - 8» Центр Электроснабжения и Автотранспорта',
        more: {
          'rooms': '3',
          'mq': '77',
          'location': 'Russia,Moscow',
          'url': 'assets/home/hotel_3.jpg',
          'details': ['assets/details/details_5.jpg', 'assets/details/details_6.jpg'],
        }
    )
  ];

  get bookmarks => null;
}
