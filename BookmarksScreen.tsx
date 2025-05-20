import React from 'react';
import { View, Text, FlatList, Image, TouchableOpacity, StyleSheet } from 'react-native';
import { MaterialIcons } from '@expo/vector-icons';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { RootStackParamList, Track } from './TrackList';

const tracks: Track[] = [
  {
    id: '1',
    title: 'Sample Track',
    artist: 'Sample Artist',
    artwork: require('./assets/icon.png'),
    file: require('./assets/sample.mp3'),
    duration: '2:34',
  },
  // 追加のトラックはここに
];

type Props = NativeStackScreenProps<RootStackParamList, 'Bookmarks'>;

export default function BookmarksScreen({ route, navigation }: Props) {
  const { bookmarks } = route.params;
  const bookmarkedTracks = tracks.filter(t => bookmarks.includes(t.id));

  return (
    <View style={styles.container}>
      <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 24 }}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={{ padding: 8 }}>
          <MaterialIcons name="arrow-back" size={32} color="#CB759E" />
        </TouchableOpacity>
        <Text style={styles.header}>お気に入り</Text>
      </View>
      {bookmarkedTracks.length === 0 ? (
        <Text style={{ color: '#A09DA1', fontSize: 18, alignSelf: 'center', marginTop: 32 }}>お気に入りはありません</Text>
      ) : (
        <FlatList
          data={bookmarkedTracks}
          keyExtractor={item => item.id}
          renderItem={({ item }) => (
            <View style={styles.card}>
              <Image source={item.artwork} style={styles.artwork} />
              <View style={styles.info}>
                <Text style={styles.title}>{item.title}</Text>
                <Text style={styles.artist}>{item.artist}</Text>
              </View>
              <View style={{ flexDirection: 'row', alignItems: 'center', marginLeft: 8 }}>
                <MaterialIcons name="schedule" size={24} color="#A09DA1" style={{ marginRight: 2 }} />
                <Text style={styles.duration}>{item.duration || '0:00'}</Text>
              </View>
            </View>
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
    paddingTop: 48,
    paddingHorizontal: 24,
  },
  header: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#191217',
    marginLeft: 8,
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
