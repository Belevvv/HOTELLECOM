import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/SharedPreferences.dart';
import 'package:flutter_application_3/models/hotel.dart';
import 'package:flutter_application_3/models/hotel_card.dart';



class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<Hotel> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await BookmarkUtils.getBookmarks();
    setState(() {
      _bookmarks = bookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text('Закладка'),
        backgroundColor:Colors.white, 
      ),
      body: ListView.separated(
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          return HotelCard(hotel: _bookmarks[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}
