import React from 'react';
import { View, Text, FlatList, Image, TouchableOpacity, StyleSheet } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { RouteProp } from '@react-navigation/native';

// 型定義
export type RootStackParamList = {
  TrackList: undefined;
  Player: { track: Track };
};

export type Track = {
  id: string;
  title: string;
  artist: string;
  artwork: any;
  file: any;
};

const tracks: Track[] = [
  {
    id: '1',
    title: 'Sample Track',
    artist: 'Sample Artist',
    artwork: require('./assets/icon.png'),
    file: require('./assets/sample.mp3'),
  },
  // 追加のトラックはここに
];

export default function TrackList() {
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList, 'TrackList'>>();

  const handlePress = (track: Track) => {
    navigation.navigate('Player', { track });
  };

  return (
    <View style={styles.container}>
      <Text style={styles.header}>音声リスト</Text>
      <FlatList
        data={tracks}
        keyExtractor={item => item.id}
        renderItem={({ item }) => (
          <TouchableOpacity style={styles.card} onPress={() => handlePress(item)}>
            <Image source={item.artwork} style={styles.artwork} />
            <View style={styles.info}>
              <Text style={styles.title}>{item.title}</Text>
              <Text style={styles.artist}>{item.artist}</Text>
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
