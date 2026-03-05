import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_7/model/songs/song.dart';
import 'package:week_7/ui/screens/library/view_model/library_view_model.dart';
import 'package:week_7/ui/states/settings_state.dart';
import 'package:week_7/ui/theme/theme.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final LibraryViewModel viewModel = context.watch<LibraryViewModel>();

    return Container(
      color: viewModel.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) => SongTile(
                song: viewModel.songs[index],
                isPlaying:
                    viewModel.playerState.currentSong == viewModel.songs[index],
                onTap: () {
                  viewModel.play(viewModel.songs[index]);
                }, onStop: viewModel.stop,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: isPlaying
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Playing', style: TextStyle(color: Colors.amber)),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: onStop,
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    'STOP',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
