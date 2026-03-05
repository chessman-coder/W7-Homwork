import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_7/data/repositories/songs/song_repository.dart';
import 'package:week_7/ui/screens/library/view_model/library_view_model.dart';
import 'package:week_7/ui/screens/library/widget/library_content.dart';
import 'package:week_7/ui/states/player_state.dart';
import 'package:week_7/ui/states/settings_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryViewModel>(
      create: (context) => LibraryViewModel(
        songRepository: context.read<SongRepository>(),
        playerState: context.read<PlayerState>(),
        appSettingState: context.read<AppSettingsState>()
      )..init(),
      child: const LibraryContent(),
    );
  }
}
