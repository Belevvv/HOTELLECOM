import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/SharedPreferences.dart';
import 'package:flutter_application_3/models/hotel.dart';
import 'package:flutter_application_3/utils/utils.dart';
import 'package:flutter_application_3/views/details.dart';
import 'package:flutter_application_3/widgets/monthly_price.dart';
import 'package:heroicons/heroicons.dart';

class HotelCard extends StatefulWidget {
  final Hotel hotel;

  const HotelCard({
    super.key,
    required this.hotel,
  });

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HotelDetails(hotel: widget.hotel)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(widget.hotel.more['url'], fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.hotel.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _toggleBookmark,
                          child: HeroIcon(
                            _isBookmarked ? HeroIcons.heart : HeroIcons.magnifyingGlass,
                            size: 30,
                            color: $utils.primary,
                            style: HeroIconStyle.solid,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.hotel.address,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        MonthlyPrice(price: widget.hotel.price),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              widget.hotel.star.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            HeroIcon(
                              HeroIcons.star,
                              size: 26,
                              style: HeroIconStyle.solid,
                              color: Colors.yellow.shade500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}