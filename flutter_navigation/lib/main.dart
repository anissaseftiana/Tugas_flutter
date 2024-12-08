import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/book_detail': (context) => BookDetailPage(),
        '/borrow': (context) => BorrowPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, String>> books = [
    {'title': 'Laut Bercerita', 'author': 'Leila S.Chudori', 'cover': 'https://via.placeholder.com/150'},
    {'title': 'Laskar Pelangi', 'author': 'Andrea Hirata', 'cover': 'https://via.placeholder.com/150'},
    {'title': 'Dilan', 'author': 'Pidi Baiq', 'cover': 'https://via.placeholder.com/150'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perpustakaan'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookCard(
            book: books[index],
            onTap: () {
              // Navigasi ke halaman detail buku
              Navigator.pushNamed(
                context,
                '/book_detail',
                arguments: books[index],
              );
            },
          );
        },
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Map<String, String> book;
  final VoidCallback onTap;

  BookCard({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book['cover']!),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book['title']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'By ${book['author']}',
                    style: TextStyle(color: Colors.blue),
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

class BookDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> book = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(book['cover']!),
            SizedBox(height: 16),
            Text(
              book['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'By ${book['author']}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman peminjaman
                Navigator.pushNamed(context, '/borrow');
              },
              child: Text('Pinjam Buku'),
            ),
          ],
        ),
      ),
    );
  }
}

class BorrowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peminjaman Buku'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Terima kasih telah meminjam buku!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kembali ke halaman beranda
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}
