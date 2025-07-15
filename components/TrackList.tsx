import { useRef, useState } from 'react';
import { View, Text, FlatList, Image, TouchableOpacity, StyleSheet, Modal } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { MaterialIcons } from '@expo/vector-icons';
import { Audio } from 'expo-av';
import AppHeader from '@components/AppHeader';
import { tracks, Track } from '../data/tracks';

// 型定義
export type RootStackParamList = {
  TrackList: undefined;
  Player: { track: Track };
  Bookmarks: { bookmarks: string[] };
  Upload: undefined;
};

export { Track } from '../data/tracks';

export default function TrackList() {
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList, 'TrackList'>>();
  const [playingId, setPlayingId] = useState<string | null>(null);
  const [bookmarks, setBookmarks] = useState<string[]>([]);
  const [drawerVisible, setDrawerVisible] = useState(false);
  const soundRef = useRef<Audio.Sound | null>(null);

  const handlePress = (track: Track) => {
    navigation.navigate('Player', { track });
  };

  const handlePlay = async (track: Track) => {
    if (soundRef.current) {
      await soundRef.current.stopAsync();
      await soundRef.current.unloadAsync();
      soundRef.current = null;
    }
    const { sound } = await Audio.Sound.createAsync(track.file, {}, (status) => {
      if (status.isLoaded && status.didJustFinish) {
        setPlayingId(null);
      }
    });
    soundRef.current = sound;
    await sound.playAsync();
    setPlayingId(track.id);
  };

  const handlePause = async () => {
    if (soundRef.current) {
      await soundRef.current.pauseAsync();
      setPlayingId(null);
    }
  };

  const handleBookmark = (trackId: string) => {
    setBookmarks((prev) =>
      prev.includes(trackId)
        ? prev.filter((id) => id !== trackId)
        : [...prev, trackId]
    );
  };

  const openDrawer = () => setDrawerVisible(true);
  const closeDrawer = () => setDrawerVisible(false);

  const renderDrawer = () => (
    <View style={{ flex: 1, backgroundColor: '#fff', paddingTop: 48, paddingHorizontal: 16 }}>
      <TouchableOpacity
        style={{ flexDirection: 'row', alignItems: 'center', padding: 20 }}
        onPress={() => {
          navigation.navigate('Bookmarks', { bookmarks });
          closeDrawer();
        }}
      >
        <MaterialIcons name="bookmark" size={28} color="#CB759E" style={{ marginRight: 12 }} />
        <Text style={{ fontSize: 18, color: '#191217' }}>お気に入り</Text>
      </TouchableOpacity>
      <TouchableOpacity
        style={{ flexDirection: 'row', alignItems: 'center', padding: 20 }}
        onPress={() => {
          navigation.navigate('Upload');
          closeDrawer();
        }}
      >
        <MaterialIcons name="cloud-upload" size={28} color="#CB759E" style={{ marginRight: 12 }} />
        <Text style={{ fontSize: 18, color: '#191217' }}>音声アップロード</Text>
      </TouchableOpacity>
      <TouchableOpacity onPress={closeDrawer} style={{ position: 'absolute', top: 16, right: 16 }}>
        <MaterialIcons name="close" size={28} color="#A09DA1" />
      </TouchableOpacity>
    </View>
  );

  return (
    <View style={{ flex: 1 }}>
      <AppHeader onMenuPress={openDrawer} title="音声リスト" />
      <Modal
        visible={drawerVisible}
        animationType="slide"
        transparent={true}
        onRequestClose={closeDrawer}
      >
        <TouchableOpacity style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.2)' }} activeOpacity={1} onPress={closeDrawer} />
        <View style={{ position: 'absolute', top: 0, right: 0, width: 240, height: '100%', backgroundColor: '#fff', shadowColor: '#000', shadowOpacity: 0.2, shadowRadius: 8, elevation: 8 }}>
          {renderDrawer()}
        </View>
      </Modal>
      <FlatList
        data={tracks}
        keyExtractor={item => item.id}
        renderItem={({ item }) => (
          <TouchableOpacity style={styles.card} onPress={() => handlePress(item)} activeOpacity={0.8}>
            <Image source={item.artwork} style={styles.artwork} />
            <View style={styles.info}>
              <Text style={styles.title}>{item.title}</Text>
              <Text style={styles.artist}>{item.artist}</Text>
            </View>
            <View style={{ flexDirection: 'row', alignItems: 'center', marginLeft: 8 }}>
              <MaterialIcons name="schedule" size={24} color="#A09DA1" style={{ marginRight: 2 }} />
              <Text style={styles.duration}>{item.duration || '0:00'}</Text>
              {playingId === item.id ? (
                <TouchableOpacity onPress={handlePause} style={{ marginLeft: 8 }}>
                  <MaterialIcons name="pause-circle-filled" size={40} color="#CB759E" />
                </TouchableOpacity>
              ) : (
                <TouchableOpacity onPress={() => handlePlay(item)} style={{ marginLeft: 8 }}>
                  <MaterialIcons name="play-circle-filled" size={40} color="#CB759E" />
                </TouchableOpacity>
              )}
              <TouchableOpacity onPress={() => handleBookmark(item.id)} style={{ marginLeft: 8 }}>
                <MaterialIcons name={bookmarks.includes(item.id) ? 'bookmark' : 'bookmark-border'} size={32} color={bookmarks.includes(item.id) ? '#CB759E' : '#A09DA1'} />
              </TouchableOpacity>
            </View>
          </TouchableOpacity>
        )}
        contentContainerStyle={{ paddingBottom: 32 }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#E5E2E9',
    paddingTop: 48,
    paddingHorizontal: 24,
  },
  header: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#191217',
    marginBottom: 24,
    alignSelf: 'center',
  },
  card: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 24,
    padding: 16,
    marginBottom: 20,
    shadowColor: '#191217',
    shadowOpacity: 0.08,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 4 },
    elevation: 4,
  },
  duration: {
    fontSize: 15,
    color: '#A09DA1',
    marginRight: 12,
    minWidth: 44,
    textAlign: 'center',
  },
  artwork: {
    width: 64,
    height: 64,
    borderRadius: 32,
    marginRight: 16,
  },
  info: {
    flex: 1,
  },
  title: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#191217',
  },
  artist: {
    fontSize: 15,
    color: '#A09DA1',
    marginTop: 4,
  },
});
