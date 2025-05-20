import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, Image, TouchableOpacity } from 'react-native';
import { Audio } from 'expo-av';
import { useState } from 'react';
import { Button } from 'react-native';
import Slider from '@react-native-community/slider';
import { MaterialIcons } from '@expo/vector-icons';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import TrackList from './TrackList';

const Stack = createNativeStackNavigator();

function PlayerScreen({ route, navigation }: { route: any; navigation: any }) {
  const track = route.params?.track;
  const [sound, setSound] = useState<Audio.Sound | null>(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [position, setPosition] = useState(0);
  const [duration, setDuration] = useState(1);

  async function playSound() {
    if (sound) {
      await sound.playAsync();
      setIsPlaying(true);
      return;
    }
    const { sound: newSound } = await Audio.Sound.createAsync(
      require('./assets/sample.mp3'),
      {},
      onPlaybackStatusUpdate
    );
    setSound(newSound);
    await newSound.playAsync();
    setIsPlaying(true);
  }

  async function pauseSound() {
    if (sound) {
      await sound.pauseAsync();
      setIsPlaying(false);
    }
  }

  async function stopSound() {
    if (sound) {
      await sound.stopAsync();
      setIsPlaying(false);
      setPosition(0);
    }
  }

  function onPlaybackStatusUpdate(status: any) {
    if (status.isLoaded) {
      setPosition(status.positionMillis);
      setDuration(status.durationMillis || 1);
      if (status.didJustFinish) {
        setIsPlaying(false);
        setPosition(0);
      }
    }
  }

  async function seek(val: number) {
    if (sound) {
      await sound.setPositionAsync(val);
      setPosition(val);
    }
  }

  function millisToMinSec(millis: number) {
    const min = Math.floor(millis / 60000);
    const sec = Math.floor((millis % 60000) / 1000);
    return `${min}:${sec.toString().padStart(2, '0')}`;
  }

  return (
    <View style={styles.container}>
      {/* ポジション（戻るヘッダー）を最上部に配置 */}
      <View style={{
        width: '100%',
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 16,
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        backgroundColor: '#E5E2E9',
        paddingTop: 48,
        paddingBottom: 8,
        zIndex: 10,
      }}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={{ padding: 8 }}>
          <MaterialIcons name="arrow-back" size={32} color="#CB759E" />
        </TouchableOpacity>
        <Text style={{ fontSize: 20, fontWeight: 'bold', color: '#191217', marginLeft: 8 }}>プレイヤー</Text>
      </View>
      {/* 下に余白を追加してヘッダーと重ならないようにする */}
      <View style={{ height: 72 }} />
      <View style={styles.artworkWrapper}>
        <Image source={track.artwork} style={styles.artwork} />
      </View>
      <Text style={styles.title}>{track.title}</Text>
      <Text style={styles.artist}>{track.artist}</Text>
      <Slider
        style={styles.slider}
        minimumValue={0}
        maximumValue={duration}
        value={position}
        minimumTrackTintColor="#CB759E"
        maximumTrackTintColor="#E5E2E9"
        thumbTintColor="#CB759E"
        onSlidingComplete={seek}
      />
      <View style={styles.timeWrapper}>
        <Text style={styles.time}>{millisToMinSec(position)}</Text>
        <Text style={styles.time}>{millisToMinSec(duration)}</Text>
      </View>
      <View style={styles.controls}>
        <MaterialIcons name="stop" size={48} color="#A09DA1" onPress={stopSound} />
        {isPlaying ? (
          <MaterialIcons name="pause-circle-filled" size={64} color="#CB759E" onPress={pauseSound} />
        ) : (
          <MaterialIcons name="play-circle-filled" size={64} color="#CB759E" onPress={playSound} />
        )}
      </View>
      <StatusBar style="auto" />
    </View>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="TrackList" screenOptions={{ headerShown: false }}>
        <Stack.Screen name="TrackList" component={TrackList} />
        <Stack.Screen name="Player" component={PlayerScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#E5E2E9',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 24,
  },
  artworkWrapper: {
    marginBottom: 32,
    shadowColor: '#191217',
    shadowOpacity: 0.2,
    shadowRadius: 16,
    shadowOffset: { width: 0, height: 8 },
    elevation: 8,
    borderRadius: 120,
    backgroundColor: '#fff',
    padding: 16,
  },
  artwork: {
    width: 180,
    height: 180,
    borderRadius: 90,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#191217',
    marginTop: 16,
    marginBottom: 4,
  },
  artist: {
    fontSize: 18,
    color: '#A09DA1',
    marginBottom: 24,
  },
  slider: {
    width: '100%',
    height: 40,
  },
  timeWrapper: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    width: '100%',
    marginBottom: 16,
  },
  time: {
    color: '#656369',
    fontSize: 14,
  },
  controls: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 32,
    marginTop: 16,
  },
});
