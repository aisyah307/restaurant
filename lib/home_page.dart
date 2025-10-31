import 'dart:math';
import 'package:flutter/material.dart';
import 'restaurant.dart';
import 'json_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = JsonService();
  bool _loading = true;
  List<Restaurant> _restaurants = [];
  List<String> _categories = [];
  Restaurant? _promo;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  //load data rekkomendasi restaurant
  Future<void> _loadData() async {
    final data = await _service.loadRestaurants();
    setState(() {
      _restaurants = data.take(5).toList();
      _categories = data //pemilihan kategori dari data bagian cuisines di json
              .map((r) => r.cuisines.split(',').first.trim())
              .toSet()
              .toList();
      //pilih random restaurant untuk latar promo
      _promo =data[Random().nextInt(data.length,)];
      _loading = false;
    });
  }

  //Bottom navigation
  void _onNavTap(int i) {
    setState(() => _index = i);
    if (i == 1) {
      Navigator.pushNamed(context, '/list');
    } else if (i == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Halaman profil belum tersedia')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            //Header profil
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/vector-1740738536404-c36db193ce34?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1160",
                      ),
                      radius: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Hi, Aisyah!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.notifications_none_rounded, size: 28),
              ],
            ),
            const SizedBox(height: 20),

            //Banner promo
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, '/detail', arguments: _promo),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.network(
                      _promo!.image,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 160,
                      padding: const EdgeInsets.all(16),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get special discount",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "up to 45%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            //Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search restaurant or dish...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            //Kategori (horizontal scroll)
            const Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: cat,
                      ),
                      child: Chip(
                        label: Text(cat),
                        backgroundColor: Colors.orange.shade50,
                        side: const BorderSide(color: Colors.orange),
                        labelStyle: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            //Rekomendasi
            const Text(
              "Popular this week",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children: _restaurants.map((r) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        r.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      r.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${r.city} - ${r.cuisines}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          r.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigasi ke halaman detail sambil mengirim data restoran yang diklik
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: r, // argumen r dikirim ke halaman detail
                      );
                    },
                  ),
                );
              }).toList(), // ubah hasil map menjadi list widget
            ),
          ],
        ),
      ),

      //Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.orange,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
