import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/hotel.dart';
import 'package:flutter_application_3/models/hotel_card.dart';
import 'package:flutter_application_3/utils/utils.dart';
import 'package:flutter_application_3/views/page/CategoryBottomSheet.dart';
import 'package:heroicons/heroicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required void Function(Hotel hotel) onBookmarkUpdated});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Hotel> _filteredHotels = [];

  @override
  void initState() {
    super.initState();
    _filteredHotels = $utils.hotels;
    print('Initial hotels: ${_filteredHotels.length}');
  }

  void _handleSearch(String query) {
    setState(() {
      _filteredHotels = $utils.hotels
          .where((hotel) =>
              hotel.name.toLowerCase().contains(query.toLowerCase()) ||
              hotel.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
      print('Filtered hotels: ${_filteredHotels.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const HeroIcon(HeroIcons.bars2),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (BuildContext context) {
                        return const CategoryBottomSheet();
                      },
                    );
                  },
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        HeroIcon(
                          HeroIcons.mapPin,
                          color: $utils.primary,
                          style: HeroIconStyle.solid,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'ОтельСвязи',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 48), 
              ],
            ),
            const SizedBox(height: 20),
            SearchBar(onSearch: _handleSearch),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Лучшие места для тебя',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: _filteredHotels.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return HotelCard(hotel: _filteredHotels[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({super.key, required this.onSearch});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          const HeroIcon(HeroIcons.magnifyingGlass),
          const SizedBox(width: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Поиск...',
                ),
                onChanged: (value) {
                  print('Search query: $value');
                  widget.onSearch(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
