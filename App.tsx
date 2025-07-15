import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import TrackList from '@components/TrackList';
import BookmarksScreen from '@components/BookmarksScreen';
import PlayerScreen from '@components/PlayerScreen';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="TrackList" screenOptions={{ headerShown: false }}>
        <Stack.Screen name="TrackList" component={TrackList} />
        <Stack.Screen name="Player" component={PlayerScreen} />
        <Stack.Screen name="Bookmarks" component={BookmarksScreen as React.ComponentType<any>} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
