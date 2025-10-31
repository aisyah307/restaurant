import 'package:flutter/material.dart';
import 'restaurant.dart';

/// Menampilkan informasi restoran dari halaman sebelumnya.
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data restoran yang dikirim melalui Navigator.pushNamed
    final restaurant = ModalRoute.of(context)!.settings.arguments as Restaurant;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(restaurant.name, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Gambar utama restoran
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                restaurant.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            //Konten detail
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Nama restoran dan rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${restaurant.city} - ${restaurant.cuisines}",
                              style: const TextStyle(color: Colors.black54),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
          
                  Text(
                    restaurant.cuisines,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  //Alamat restoran
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${restaurant.address}, ${restaurant.city}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Harga rata-rata
                  Row(
                    children: [
                      const Icon(Icons.attach_money, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        "Rata-rata: ${restaurant.averageCostForTwo} ${restaurant.currency}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Status online delivery
                  Row(
                    children: [
                      Icon(
                        restaurant.hasOnlineDelivery
                            ? Icons.delivery_dining
                            : Icons.block,
                        color: restaurant.hasOnlineDelivery
                            ? Colors.green
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        restaurant.hasOnlineDelivery
                            ? "Tersedia Online Delivery"
                            : "Tidak Tersedia Online Delivery",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Status booking meja
                  Row(
                    children: [
                      Icon(
                        restaurant.hasTableBooking
                            ? Icons.event_seat
                            : Icons.close,
                        color: restaurant.hasTableBooking
                            ? Colors.green
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        restaurant.hasTableBooking
                            ? "Tersedia Pemesanan Meja"
                            : "Tanpa Pemesanan Meja",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Jumlah ulasan
                  Center(
                    child: Text(
                      "${restaurant.votes} pengguna telah memberi ulasan",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 🔹 Tombol aksi (belum aktif)
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Fitur ulasan belum tersedia untuk saat ini",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.reviews),
                      label: const Text("Berikan Ulasan"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
