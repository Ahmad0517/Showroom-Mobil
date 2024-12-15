import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Showroom Mobil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

// Halaman Login
class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/logo-showroom.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Judul Halaman
              Text(
                'Welcome to Showroom Mobil',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),

              // Input Username
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15.0),

              // Input Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 10.0),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot Password Action
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Tombol Login
              ElevatedButton(
                onPressed: () {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  // Validasi login admin
                  if (username == 'admin' && password == '1234') {
                    // Pindah ke halaman daftar mobil jika login berhasil
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarListPage(),
                      ),
                    );
                  } else {
                    // Tampilkan pesan error jika login gagal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid username or password'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman List Mobil
class CarListPage extends StatelessWidget {
  final List<Map<String, String>> cars = [
    {
      'name': 'Toyota Supra',
      'image':
          'https://imgcdnblog.carmudi.com.ph/wp-content/uploads/2022/12/08124404/Toyota-GR-Supra-2022-3.jpg',
      'price': 'Rp 1.500.000.000',
    },
    {
      'name': 'Ford Mustang',
      'image':
          'https://static1.hotcarsimages.com/wordpress/wp-content/uploads/2021/06/ford-mustang-mach-e-ford-2-Cropped.jpg',
      'price': 'Rp 2.000.000.000',
    },
    {
      'name': 'BMW i8',
      'image': 'https://i.ytimg.com/vi/vQfP_m7Zcdw/sddefault.jpg',
      'price': 'Rp 3.000.000.000',
    },
    {
      'name': 'Tesla Model S',
      'image':
          'https://topelectricsuv.com/wp-content/uploads/2022/04/Tesla-Roadster-front-three-quarter-with-roof-retracted.jpg',
      'price': 'Rp 2.500.000.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mobil'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  car['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                car['name']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                car['price']!,
                style: TextStyle(color: Colors.blue),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailPage(car: car),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman Detail Mobil
class CarDetailPage extends StatelessWidget {
  final Map<String, String> car;

  CarDetailPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['name']!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              car['image']!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              car['name']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              car['price']!,
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi Mobil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Mobil dengan desain elegan dan performa tinggi, cocok untuk pecinta kecepatan dan kenyamanan.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
