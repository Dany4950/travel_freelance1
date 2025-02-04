import 'package:flutter/material.dart';
import 'package:travel/display_attractions.dart';

// Import the AttractionsScreen

class TravelScreen extends StatefulWidget {
  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  String dest = '';
  int days = 1;
  String budget = '0';

  final List<int> _daysList = List<int>.generate(30, (index) => index + 1);
  final Map<String, List<String>> popularLocations = {
    'Mumbai': [
      'Gateway of India',
      'Marine Drive',
      'Elephanta Caves',
      'Chhatrapati Shivaji Terminus',
      'Haji Ali Dargah',
      'Siddhivinayak Temple',
      'Juhu Beach',
      'Colaba Causeway',
      'Sanjay Gandhi National Park',
      'Worli Sea Face',
    ],
    'Paris': [
      'Eiffel Tower',
      'Louvre Museum',
      'Notre-Dame Cathedral',
      'Montmartre and Sacré-Cœur Basilica',
      'Champs-Élysées',
      'Arc de Triomphe',
      'Seine River Cruise',
      'Palace of Versailles',
    ],
    'New York': [
      'Statue of Liberty',
      'Central Park',
      'Times Square',
      'Empire State Building',
      'Brooklyn Bridge',
      'Rockefeller Center',
      'The Metropolitan Museum of Art',
      'Broadway',
    ],
    'Tokyo': [
      'Shibuya Crossing',
      'Tokyo Tower',
      'Senso-ji Temple',
      'Meiji Shrine',
      'Akihabara',
      'Odaiba',
      'Tsukiji Fish Market',
      'Ueno Park and Zoo',
    ],
    'London': [
      'Big Ben and Houses of Parliament',
      'London Eye',
      'Buckingham Palace',
      'Tower of London',
      'Tower Bridge',
      'The British Museum',
      'Westminster Abbey',
      'St. Paul\'s Cathedral',
    ],
    'Manali': [
      'Solang Valley',
      'Rohtang Pass',
      'Hadimba Temple',
      'Manu Temple',
      'Old Manali',
      'Jogini Waterfall',
      'Vashisht Hot Water Springs',
      'Mall Road',
    ],
    'Kashmir': [
      'Dal Lake',
      'Gulmarg',
      'Sonmarg',
      'Pahalgam',
      'Betaab Valley',
      'Nishat Bagh',
      'Shankaracharya Temple',
      'Aru Valley',
    ],
  };

  final Map<String, List<String>> nearbyCities = {
    'Paris': ['Versailles', 'Lyon', 'Nice', 'Lille'],
    'New York': ['Boston', 'Philadelphia', 'Washington D.C.', 'Atlantic City'],
    'Tokyo': ['Yokohama', 'Kyoto', 'Osaka', 'Hakone'],
    'London': ['Cambridge', 'Oxford', 'Brighton', 'Bath'],
    'Mumbai': ['Pune', 'Nashik', 'Lonavala', 'Alibaug'],
    'Manali': ['Kullu', 'Naggar', 'Kasol', 'Manikaran'],
    'Kashmir': ['Gulmarg', 'Sonmarg', 'Pahalgam', 'Kupwara'],

    // Add more cities and their nearby cities as needed
  };
  final Map<String, List<String>> InnerCityActivities = {
    'Paris': [
      'Rafting',
      'Skycycling',
      'WineTasting',
      'Ballooning',
    ],
    'New York': [
      'Cycling',
      'Skydiving',
      'Broadway',
      'FerryRide',
    ],
    'Tokyo': [
      'Rafting',
      'BungeeJumping',
      'Sumo',
      'BulletTrain',
    ],
    'London': [
      'Cycling',
      'Rafting',
      'Ziplining',
      'LondonEye',
    ],
    'Mumbai': [
      'Rafting',
      'Trekking',
      'Paragliding',
      'Snorkeling',
    ],
    'Manali': [
      'Rafting',
      'Trekking',
      'Skiing',
      'Ziplining',
    ],
    'Kashmir': [
      'Skiing',
      'Trekking',
      'Fishing',
      'HorseRiding',
    ],
  };

  void _navigateToAttractionsScreen(BuildContext context) {
    if (dest.isEmpty || budget.isEmpty || days < 1) {
      // Show an error if any field is not filled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter all details.")),
      );
      return;
    }

    // Check if the destination is in the popularLocations map
    if (popularLocations.containsKey(dest)) {
      // Navigate to the next screen and pass the popular locations, days, budget, and nearby cities
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AttractionsScreen(
            InnerCityActivities: InnerCityActivities[dest] ?? [],
            popularLocations: popularLocations[dest]!,
            maxSelectedImages: 8,
            days: days,
            budget: budget,
            nearbyCities: nearbyCities[dest] ?? [],
            dest: dest,
          ),
        ),
      );
    } else {
      // Show an error if the destination is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Destination not found. Please try another city.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel App'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Resources/back_input.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Destination',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'Montserrat'),
                    onChanged: (value) {
                      setState(() {
                        dest = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Days',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Montserrat'),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _daysList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                days = _daysList[index];
                              });
                            },
                            child: Container(
                              width: 60,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: days == _daysList[index]
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  '${_daysList[index]}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your budget (e.g., 5000 Rupees)',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'Montserrat'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        budget = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToAttractionsScreen(context);
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
