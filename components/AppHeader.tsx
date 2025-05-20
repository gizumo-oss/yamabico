import React from 'react';
import { View, Text, Image, TouchableOpacity } from 'react-native';
import { MaterialIcons } from '@expo/vector-icons';

export default function AppHeader({ onMenuPress, title }: { onMenuPress: () => void, title: string }) {
  return (
    <View style={{ flexDirection: 'row', alignItems: 'center', paddingTop: 48, paddingBottom: 16, paddingHorizontal: 24, backgroundColor: '#E5E2E9' }}>
      <Image source={require('../assets/icon.png')} style={{ width: 36, height: 36, borderRadius: 8, marginRight: 12 }} />
      <Text style={{ fontSize: 24, fontWeight: 'bold', color: '#191217', flex: 1 }}>{title}</Text>
      <TouchableOpacity onPress={onMenuPress} style={{ padding: 8 }}>
        <MaterialIcons name="menu" size={32} color="#CB759E" />
      </TouchableOpacity>
    </View>
  );
}
