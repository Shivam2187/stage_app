// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   List<String> data = [
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Date',
//     'Elderberry',
//     'Fig',
//     'Grapes',
//     'Honeydew',
//     'Kiwi',
//     'Lemon',
//   ];

//   List<String> searchResults = [];

//   void onQueryChanged(String query) {
//     setState(() {
//       searchResults = data
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return   Column(
//         children: [
//           SearchBar(onQueryChanged: onQueryChanged),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchResults.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(searchResults[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//   }
// }

// class SearchBar extends StatefulWidget {
//   final ValueChanged<String> onQueryChanged;

//   const SearchBar({super.key, required this.onQueryChanged});
//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   String query = '';

//   void onQueryChanged(String newQuery) {
//     setState(() {
//       query = newQuery;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: TextField(
//         onChanged: (value) {
//           onQueryChanged(value);
//           widget.onQueryChanged(value);
//         },
//         decoration: const InputDecoration(
//           labelText: 'Search',
//           border: OutlineInputBorder(),
//           prefixIcon: Icon(Icons.search),
//         ),
//       ),
//     );
//   }
// }
