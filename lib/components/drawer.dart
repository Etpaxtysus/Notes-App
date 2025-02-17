import 'package:flutter/material.dart';
import 'package:notesapp/components/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Header
          DrawerHeader(
            child: Icon(Icons.note),
          ),
          // Notes Tile
          DrawerTile(
              title: "Notes",
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context)),
          // Settings Tile
          DrawerTile(
              title: "Settings",
              leading: const Icon(Icons.settings),
              onTap: () {}),
        ],
      ),
    );
  }
}
