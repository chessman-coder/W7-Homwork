import 'package:flutter/material.dart';
import 'package:week_7/data/repositories/songs/song_repository.dart';
import 'package:week_7/model/songs/song.dart';
import 'package:week_7/ui/states/player_state.dart';
import 'package:week_7/ui/states/settings_state.dart';

class LibraryViewModel extends ChangeNotifier {
  LibraryViewModel({
    required this.playerState,
    required this.songRepository,
    required this.appSettingState,
  });

  final SongRepository songRepository;
  final PlayerState playerState;
  final AppSettingsState appSettingState;

  bool _init = false;
  List<Song> _song = const [];
  List<Song> get songs => _song;

  Song? get currentSong => playerState.currentSong;

  Color get background => appSettingState.theme.backgroundColor;

  void init() {
    if (!_init) {
      _init = true;
    }

    _song = songRepository.fetchSongs();
    notifyListeners();
  }

  void play(Song song) {
    playerState.start(song);
    notifyListeners();
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }

  void _onPlayerChange() {
    notifyListeners();
  }

  @override
  void dispose() {
    playerState.removeListener(_onPlayerChange);
    super.dispose();
  }
}
