import React, { useRef, useState } from 'react';
import { View, Text, FlatList, Image, TouchableOpacity, StyleSheet, Modal } from 'react-native';
import { MaterialIcons } from '@expo/vector-icons';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { Audio } from 'expo-av';
import AppHeader from '@components/AppHeader';
import { RootStackParamList, Track } from '@components/TrackList';
import { tracks } from '../data/tracks';


type Props = NativeStackScreenProps<RootStackParamList, 'Bookmarks'>;

export default function BookmarksScreen({ route, navigation }: Props) {
  const { bookmarks } = route.params;
  const [bookmarkIds, setBookmarkIds] = useState<string[]>(bookmarks);
  const bookmarkedTracks = tracks.filter(t => bookmarkIds.includes(t.id));
  const [playingId, setPlayingId] = useState<string | null>(null);
  const soundRef = useRef<Audio.Sound | null>(null);
  const [drawerVisible, setDrawerVisible] = useState(false);
  const openDrawer = () => setDrawerVisible(true);
  const closeDrawer = () => setDrawerVisible(false);

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

  const handleRemoveBookmark = (trackId: string) => {
    setBookmarkIds(prev => prev.filter(id => id !== trackId));
  };

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
      <TouchableOpacity onPress={closeDrawer} style={{ position: 'absolute', top: 16, right: 16 }}>
        <MaterialIcons name="close" size={28} color="#A09DA1" />
      </TouchableOpacity>
    </View>
  );

  return (
    <View style={styles.container}>
      <AppHeader onMenuPress={openDrawer} title="お気に入り" />
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
      {bookmarkedTracks.length === 0 ? (
        <Text style={{ color: '#A09DA1', fontSize: 18, alignSelf: 'center', marginTop: 32 }}>お気に入りはありません</Text>
      ) : (
        <FlatList
          data={bookmarkedTracks}
          keyExtractor={item => item.id}
          renderItem={({ item }) => (
            <TouchableOpacity style={styles.card} onPress={() => navigation.navigate('Player', { track: item })} activeOpacity={0.8}>
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
                <TouchableOpacity onPress={() => handleRemoveBookmark(item.id)} style={{ marginLeft: 8 }}>
                  <MaterialIcons name="bookmark-remove" size={32} color="#A09DA1" />
                </TouchableOpacity>
              </View>
            </TouchableOpacity>
          )}
          contentContainerStyle={{ paddingBottom: 32 }}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#E5E2E9',
    paddingTop: 0,
    paddingHorizontal: 24,
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
  duration: {
    fontSize: 15,
    color: '#A09DA1',
    marginRight: 12,
    minWidth: 44,
    textAlign: 'center',
  },
});
