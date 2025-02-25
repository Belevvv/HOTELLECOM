import 'package:flutter/material.dart';
import 'package:flutter_application_3/details/photo_details.dart';
import 'package:flutter_application_3/models/SharedPreferences.dart';
import 'package:flutter_application_3/models/hotel.dart';
import 'package:flutter_application_3/utils/utils.dart';
import 'package:flutter_application_3/views/page/bookmarks_page.dart';
import 'package:flutter_application_3/widgets/monthly_price.dart';
import 'package:heroicons/heroicons.dart';

class HotelDetails extends StatefulWidget {
  final Hotel hotel;

  const HotelDetails({
    super.key,
    required this.hotel,
  });

  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}
void _showPaymentModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Платёж',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Номер карты',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Дата (MM/YY)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.datetime,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'CVV',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Успешный платёж!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: $utils.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
            child: const Text(
              'Подтвердите платёж',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

class _HotelDetailsState extends State<HotelDetails> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final isBookmarked = await BookmarkUtils.isBookmarked(widget.hotel.name);
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  Future<void> _toggleBookmark() async {
    if (_isBookmarked) {
      await BookmarkUtils.removeBookmark(widget.hotel.name);
    } else {
      await BookmarkUtils.addBookmark(widget.hotel);
    }
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const HeroIcon(HeroIcons.chevronLeft),
                  onPressed: () => Navigator.pop(context),
                ),
                Row(
                  children: [
                    IconButton(
  icon: HeroIcon(
    _isBookmarked
        ? HeroIcons.bookmark 
        : HeroIcons.bookmark, 
    color: _isBookmarked ? $utils.primary : Colors.grey, 
    style: _isBookmarked ? HeroIconStyle.solid : HeroIconStyle.outline,
  ),
  onPressed: _toggleBookmark,
  tooltip: 'Закладка',
),

                    IconButton(
                      icon: const HeroIcon(HeroIcons.bookmarkSquare),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookmarksPage(),
                          ),
                        );
                      },
                      tooltip: 'Просмотр закладки',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.hotel.more['url'],
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            PhotoDetails(photos: widget.hotel.more['details']),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.hotel.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.hotel.star.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    HeroIcon(
                      HeroIcons.star,
                      size: 28,
                      style: HeroIconStyle.solid,
                      color: Colors.yellow.shade500,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.hotel.address,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                MonthlyPrice(price: widget.hotel.price),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget.hotel.more['rooms']} Команты',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 40,
                    color: Colors.black26,
                  ),
                  Text(
                    '${widget.hotel.more['mq']} mq',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                HeroIcon(
                  HeroIcons.mapPin,
                  size: 30,
                  color: $utils.primary,
                  style: HeroIconStyle.solid,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.hotel.more['location'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              widget.hotel.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),

      
      floatingActionButton: GestureDetector(
  onTap: () => _showPaymentModal(context),
  child: Container(
    height: 65,
    margin: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: $utils.primary,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Center(
      child: Text(
        'Забронировать сейчас',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
