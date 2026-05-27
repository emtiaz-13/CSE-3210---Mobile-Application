import 'package:flutter/material.dart';
import 'donor_list_screen.dart';

class SearchDonorScreen extends StatefulWidget {
  const SearchDonorScreen({super.key});

  @override
  State<SearchDonorScreen> createState() => _SearchDonorScreenState();
}

class _SearchDonorScreenState extends State<SearchDonorScreen> {
  String? selectedLocation;
  String? selectedBloodType;

  final List<String> locations = [
    'Barguna',
    'Barisal',
    'Bhola',
    'Bogra',
    'Bramanbaria',
    'Chandpur',
    'Chittagong',
    'Chuadanga',
    'Comilla',
    "Cox's Bazar",
    'Dhaka',
    'Dinajpur',
    'Feni',
    'Gazipur',
    'Habiganj',
    'Jessore',
    'Jhalokati',
    'Jhenaidah',
    'Khulna',
    'Kurigram',
    'Kushtia',
    'Lalmonirhat',
    'Magura',
    'Meherpur',
    'Moulvibazar',
    'Mymensingh',
    'Narail',
    'Narayanganj',
    'Nilphamari',
    'Noakhali',
    'Pabna',
    'Panchagarh',
    'Pirojpur',
    'Rajshahi',
    'Rangpur',
    'Satkhira',
    'Sunamganj',
    'Sylhet',
    'Tangail',
    'Thakurgaon',
  ];

  final List<String> bloodTypes = [
    'O+',
    'O-',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
  ];

  Widget _buildPill({
    required IconData icon,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8C8C8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3A0000), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                dropdownColor: const Color(0xFF2B0000),
                iconEnabledColor: const Color(0xFF3A0000),

                selectedItemBuilder: (context) {
                  return items.map((item) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Color(0xFF6B0000),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  }).toList();
                },

                hint: Text(
                  hint,
                  style: const TextStyle(
                    color: Color(0xFF3A0000),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }).toList(),

                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [Color(0xFF6B0000), Color(0xFF1A0000)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white70,
                    size: 28,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const Spacer(flex: 2),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    _buildPill(
                      icon: Icons.location_on,
                      hint: 'Location',
                      value: selectedLocation,
                      items: locations,
                      onChanged: (val) =>
                          setState(() => selectedLocation = val),
                    ),
                    const SizedBox(height: 20),
                    _buildPill(
                      icon: Icons.water_drop,
                      hint: 'Blood Type',
                      value: selectedBloodType,
                      items: bloodTypes,
                      onChanged: (val) =>
                          setState(() => selectedBloodType = val),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (selectedLocation != null && selectedBloodType != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => DonorListScreen(
                            location: selectedLocation!,
                            bloodType: selectedBloodType!,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select both location and blood type',
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8C8C8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 42,
                      color: Color(0xFF1A0000),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
