import 'package:flutter_application_3/models/hotel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkUtils {
  static const String _bookmarksKey = 'bookmarks';


  static Future<List<Hotel>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];
    return bookmarksJson.map((json) => Hotel.fromMap(jsonDecode(json))).toList();
  }

  static Future<void> addBookmark(Hotel hotel) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.add(hotel);
    final bookmarksJson = bookmarks.map((hotel) => jsonEncode(hotel.toMap())).toList();
    await prefs.setStringList(_bookmarksKey, bookmarksJson);
  }

  static Future<void> removeBookmark(String hotelName) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.removeWhere((hotel) => hotel.name == hotelName);
    final bookmarksJson = bookmarks.map((hotel) => jsonEncode(hotel.toMap())).toList();
    await prefs.setStringList(_bookmarksKey, bookmarksJson);
  }

  static Future<bool> isBookmarked(String hotelName) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((hotel) => hotel.name == hotelName);
  }
}