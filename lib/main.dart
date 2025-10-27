import 'package:flutter/material.dart';
import 'models/property.dart';
import 'pages/listings_page.dart';
import 'pages/profile_page.dart';
import 'pages/property_detail_page.dart';

void main() => runApp(PropertyDashApp());

class PropertyDashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Properti Dash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ListingsPage(listings: [...sampleFeatured, ...sampleRecent])),
      );
      return;
    }
    if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Properti'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          Stack(
            children: [
              IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
              Positioned(right: 12, top: 12, child: CircleAvatar(radius: 6, backgroundColor: Colors.red)),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 12),
              _buildMetricsRow(),
              SizedBox(height: 18),
              _buildSectionTitle('Featured Listings', actionLabel: 'See all'),
              SizedBox(height: 8),
              _buildFeaturedList(),
              SizedBox(height: 18),
              _buildSectionTitle('Recent Listings'),
              SizedBox(height: 8),
              _buildRecentGrid(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {}, icon: Icon(Icons.add), label: Text('Tambah Listing')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Listings'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Rahmad Ade Akbar'),
            accountEmail: Text('raatechnomedia@gmail.com'),
            currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/seed/me/200')),
          ),
          ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
          ListTile(leading: Icon(Icons.favorite_border), title: Text('Saved')),
          ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          Spacer(),
          ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(colors: [Colors.indigo.shade700, Colors.indigo.shade400]),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selamat Datang, Ade', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Kelola listing properti Anda. Lihat performa, tambahkan listing, dan terima penawaran.', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 12),
                Row(children: [ _miniStat('Listings', '124'), SizedBox(width: 12), _miniStat('Penjualan', '28') ]),
              ],
            ),
          ),
          SizedBox(width: 12),
          ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network('https://picsum.photos/seed/house/120/120', width: 100, height: 100, fit: BoxFit.cover)),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildMetricsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ _metricCard(Icons.home, 'Properties', '152'), _metricCard(Icons.attach_money, 'Revenue', 'Rp 4.2M'), _metricCard(Icons.trending_up, 'Leads', '39') ],
    );
  }

  Widget _metricCard(IconData icon, String label, String value) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: Colors.indigo.shade50, child: Icon(icon, color: Colors.indigo)),
              SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: TextStyle(fontWeight: FontWeight.bold)), Text(label, style: TextStyle(color: Colors.black54, fontSize: 12))]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {String? actionLabel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (actionLabel != null) TextButton(onPressed: () {}, child: Text(actionLabel)),
      ],
    );
  }

  Widget _buildFeaturedList() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sampleFeatured.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final p = sampleFeatured[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailPage(property: p))),
            child: Container(
              width: 320,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(p.imageUrl, height: 130, width: double.infinity, fit: BoxFit.cover)),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p.title, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 6), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(p.location, style: TextStyle(color: Colors.black54, fontSize: 12)), Text(p.price, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold))])]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.9),
      itemCount: sampleRecent.length,
      itemBuilder: (context, index) {
        final p = sampleRecent[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailPage(property: p))),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(10)), child: Image.network(p.imageUrl, width: double.infinity, fit: BoxFit.cover))),
                Padding(padding: EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), SizedBox(height: 4), Text(p.location, style: TextStyle(color: Colors.black54, fontSize: 12)), SizedBox(height: 6), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(p.price, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)), Icon(Icons.favorite_border, size: 18, color: Colors.grey)])])),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'models/property.dart';
import 'pages/listings_page.dart';
import 'pages/profile_page.dart';
import 'pages/property_detail_page.dart';

void main() => runApp(PropertyDashApp());

class PropertyDashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Properti Dash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardPage(),
    );
  }
}

// Property model and sample data moved to `lib/models/property.dart`

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    if (index == 1) {
      // Open listings page
      Navigator.push(
        return Expanded(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.indigo.shade50, child: Icon(icon, color: Colors.indigo)),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(label, style: TextStyle(color: Colors.black54, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        ],
      Widget _buildSectionTitle(String title, {String? actionLabel}) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            if (actionLabel != null) TextButton(onPressed: () {}, child: Text(actionLabel)),
          ],
        );
      }

      Widget _buildFeaturedList() {
        return SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sampleFeatured.length,
            separatorBuilder: (_, __) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              final p = sampleFeatured[index];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailPage(property: p))),
                child: Container(
                  width: 320,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(p.imageUrl, height: 130, width: double.infinity, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.title, style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(p.location, style: TextStyle(color: Colors.black54, fontSize: 12)),
                                  Text(p.price, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      Widget _buildRecentGrid() {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          itemCount: sampleRecent.length,
          itemBuilder: (context, index) {
            final p = sampleRecent[index];
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailPage(property: p))),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(p.imageUrl, width: double.infinity, fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 4),
                          Text(p.location, style: TextStyle(color: Colors.black54, fontSize: 12)),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(p.price, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                              Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

  Widget _miniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildMetricsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _metricCard(Icons.home, 'Properties', '152'),
        _metricCard(Icons.attach_money, 'Revenue', 'Rp 4.2M'),
        _metricCard(Icons.trending_up, 'Leads', '39'),
      ],
    );
  }

  Widget _metricCard(IconData icon, String label, String value) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.indigo.shade50,
                    child: Icon(icon, color: Colors.indigo),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        label,
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildSectionTitle(String title, {String? actionLabel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (actionLabel != null)
          TextButton(onPressed: () {}, child: Text(actionLabel)),
      ],
    );
  }

  Widget _buildFeaturedList() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sampleFeatured.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final p = sampleFeatured[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailPage(property: p))),
            child: Container(
              width: 320,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(p.imageUrl, height: 130, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(p.location, style: TextStyle(color: Colors.black54, fontSize: 12)),
                              Text(p.price, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: sampleRecent.length,
      itemBuilder: (context, index) {
        final p = sampleRecent[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailPage(property: p))),
          child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    p.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(height: 4),
                    Text(p.location, style: TextStyle(color: Colors.black54, fontSize: 12)),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(p.price, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
