// import 'package:flutter/material.dart';

// class DaySelectionScreen extends StatefulWidget {
//   final List<String> selectedLabels;

//   const DaySelectionScreen({required this.selectedLabels, required String budget});

//   @override
//   _DaySelectionScreenState createState() => _DaySelectionScreenState();
// }

// class _DaySelectionScreenState extends State<DaySelectionScreen> {
//   List<String> _selectedLabels = [];

//   @override
//   void initState() {
//     super.initState();
//     _selectedLabels = widget.selectedLabels;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selected Labels'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ReorderableListView(
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   if (newIndex > oldIndex) {
//                     newIndex -= 1;
//                   }
//                   final String item = _selectedLabels.removeAt(oldIndex);
//                   _selectedLabels.insert(newIndex, item);
//                 });
//               },
//               children: List.generate(
//                 _selectedLabels.length,
//                 (index) {
//                   return Card(
//                     key: ValueKey(_selectedLabels[index]),
//                     child: ListTile(
//                       title: Text(
//                         _selectedLabels[index],
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18.0,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),

//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:travel/main.dart';


class DaySelectionScreen extends StatelessWidget {
  final List<String> selectedLabels;
  final String budget;

  DaySelectionScreen({required this.selectedLabels, required this.budget});

  @override
  Widget build(BuildContext context) {
    // Convert the budget string to an integer
    int parsedBudget = int.tryParse(budget) ?? 0;

    // Determine transportation based on budget
    String transportation;
    String transportationImage;
    if (parsedBudget < 10000) {
      transportation = 'Bus';
      transportationImage = 'assets/bus.png';
    } else if (parsedBudget >= 10000 && parsedBudget < 20000) {
      transportation = 'Train';
      transportationImage = 'assets/train.png'; // Trai
    } else {
      transportation = 'Plane';
      transportationImage = 'assets/plane.png'; // Plane
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Selection'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Locations:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Display selected locations
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedLabels.map((location) {
                  return Text(location, style: TextStyle(fontSize: 16));
                }).toList(),
              ),
            ),
            // Display transportation mode based on the budget
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recommended Transportation:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transportation,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                transportationImage,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImageScreen()));
                },
                child: Text("EXIT"))
          ],
        ),
      ),
    );
  }
}
