


import 'package:flutter/material.dart';
import 'single_attraction.dart';


class AttractionsScreen extends StatefulWidget {
  final List<String> popularLocations;
  final int maxSelectedImages;
  final int days;
  final String budget;
  final List<String> nearbyCities;
  final List<String> InnerCityActivities;
  final String dest;

  AttractionsScreen({
    required this.popularLocations,
    required this.maxSelectedImages,
    required this.days,
    required this.budget,
    required this.nearbyCities,
    required this.dest,
required this.InnerCityActivities,

  });

  @override
  _AttractionsScreenState createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  final Set<int> _selectedImages = {};
  late final int _maxSelectedImages;
  List<String> selectedLabels = [];

  @override
  void initState() {
    super.initState();
    _maxSelectedImages = widget.maxSelectedImages;
  }

  void _selectImage(int index) {
    setState(() {
      if (_selectedImages.contains(index)) {
        _selectedImages.remove(index);
        selectedLabels.remove(widget.popularLocations[index]);
      } else if (_selectedImages.length < _maxSelectedImages) {
        _selectedImages.add(index);
        selectedLabels.add(widget.popularLocations[index]);
      }
    });
  }

  void _navigateToNextPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DaySelectionScreen(
          selectedLabels: selectedLabels,
          budget: widget.budget, // Fix: Pass the budget correctly
        ),
      ),
    );
  }

  int _calculateLocationsToShow() {
    int baseLocations = 8; // Default number of locations
    int parsedBudget = int.tryParse(widget.budget) ?? 0; // Handle invalid input

    if (widget.days >= 7 && parsedBudget > 10000) {
      return widget.popularLocations.length; // Show all locations
    } else if (widget.days >= 4 && parsedBudget > 5000) {
      return (widget.popularLocations.length / 2)
          .ceil(); // Show half the locations
    } else {
      return baseLocations; // Show default number of locations
    }
  }

  @override
  Widget build(BuildContext context) {
    int locationsToShow = _calculateLocationsToShow();
    List<String> displayedLocations =
        widget.popularLocations.sublist(0, locationsToShow);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Locations'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNextPage,
        child: const Icon(Icons.arrow_forward),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Popular Locations in ${widget.dest}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: displayedLocations.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (BuildContext context, int index) {
                final location = displayedLocations[index];
                final isSelected = _selectedImages.contains(index);
                return InkWell(
                  onTap: () {
                    _selectImage(index);
                  },
                  child: Stack(
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isSelected ? 0.5 : 1.0,
                        child: Image.asset(
                          'assets/$location.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                      if (isSelected)
                        const Positioned.fill(
                          child: Icon(Icons.check, color: Colors.blue),
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text(
                            displayedLocations[index],
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (widget.nearbyCities.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nearby Cities to Explore',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.nearbyCities.map((city) {
                        return Chip(
                          label: Text(city),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'In City Activities  to Explore',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.InnerCityActivities.map((city) {
                        return Chip(
                          label: Text(city),
                        );
                      }).toList(),
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

