import { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert, Modal, TextInput, ScrollView } from 'react-native';
import { MaterialIcons } from '@expo/vector-icons';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import * as DocumentPicker from 'expo-document-picker';
import AppHeader from '@components/AppHeader';
import { RootStackParamList } from '@components/TrackList';

type Props = NativeStackScreenProps<RootStackParamList, 'Upload'>;

export default function UploadScreen({ navigation }: Props) {
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [selectedFile, setSelectedFile] = useState<DocumentPicker.DocumentPickerResult | null>(null);
  const [title, setTitle] = useState('');
  const [artist, setArtist] = useState('');
  const [isUploading, setIsUploading] = useState(false);

  const openDrawer = () => setDrawerVisible(true);
  const closeDrawer = () => setDrawerVisible(false);

  const renderDrawer = () => (
    <View style={{ flex: 1, backgroundColor: '#fff', paddingTop: 48, paddingHorizontal: 16 }}>
      <TouchableOpacity
        style={{ flexDirection: 'row', alignItems: 'center', padding: 20 }}
        onPress={() => {
          navigation.navigate('Bookmarks', { bookmarks: [] });
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

  const pickAudioFile = async () => {
    try {
      const result = await DocumentPicker.getDocumentAsync({
        type: ['audio/*'],
        copyToCacheDirectory: true,
      });
      
      if (!result.canceled && result.assets && result.assets.length > 0) {
        setSelectedFile(result);
        if (result.assets[0].name) {
          // ファイル名から拡張子を除いてタイトルとして設定
          const fileName = result.assets[0].name.replace(/\.[^/.]+$/, '');
          setTitle(fileName);
        }
      }
    } catch (error) {
      Alert.alert('エラー', 'ファイルの選択に失敗しました');
    }
  };

  const uploadAudio = async () => {
    if (!selectedFile || selectedFile.canceled || !selectedFile.assets || selectedFile.assets.length === 0) {
      Alert.alert('エラー', 'ファイルが選択されていません');
      return;
    }

    if (!title.trim()) {
      Alert.alert('エラー', 'タイトルを入力してください');
      return;
    }

    if (!artist.trim()) {
      Alert.alert('エラー', 'アーティスト名を入力してください');
      return;
    }

    setIsUploading(true);
    
    try {
      // 実際のアップロード処理はここに実装
      // 今回はシミュレーションとして2秒待機
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      Alert.alert('成功', '音声ファイルがアップロードされました', [
        {
          text: 'OK',
          onPress: () => {
            setSelectedFile(null);
            setTitle('');
            setArtist('');
            navigation.goBack();
          }
        }
      ]);
    } catch (error) {
      Alert.alert('エラー', 'アップロードに失敗しました');
    } finally {
      setIsUploading(false);
    }
  };

  return (
    <View style={styles.container}>
      <AppHeader onMenuPress={openDrawer} title="音声アップロード" onBackPress={() => navigation.goBack()} />
      
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

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        <View style={styles.uploadArea}>
          <TouchableOpacity style={styles.filePickerButton} onPress={pickAudioFile}>
            <MaterialIcons name="cloud-upload" size={48} color="#CB759E" />
            <Text style={styles.filePickerButtonText}>音声ファイルを選択</Text>
            <Text style={styles.filePickerSubText}>MP3, WAV, M4A対応</Text>
          </TouchableOpacity>
          
          {selectedFile && !selectedFile.canceled && selectedFile.assets && selectedFile.assets.length > 0 && (
            <View style={styles.selectedFileInfo}>
              <MaterialIcons name="music-note" size={24} color="#CB759E" />
              <View style={styles.fileInfo}>
                <Text style={styles.fileName}>{selectedFile.assets[0].name}</Text>
                <Text style={styles.fileSize}>
                  {selectedFile.assets[0].size ? `${(selectedFile.assets[0].size / 1024 / 1024).toFixed(2)} MB` : ''}
                </Text>
              </View>
              <TouchableOpacity onPress={() => setSelectedFile(null)} style={styles.removeButton}>
                <MaterialIcons name="close" size={20} color="#A09DA1" />
              </TouchableOpacity>
            </View>
          )}
        </View>

        <View style={styles.formSection}>
          <Text style={styles.sectionTitle}>楽曲情報</Text>
          
          <View style={styles.inputContainer}>
            <Text style={styles.inputLabel}>タイトル *</Text>
            <TextInput
              style={styles.textInput}
              value={title}
              onChangeText={setTitle}
              placeholder="楽曲のタイトルを入力"
              placeholderTextColor="#A09DA1"
            />
          </View>

          <View style={styles.inputContainer}>
            <Text style={styles.inputLabel}>アーティスト *</Text>
            <TextInput
              style={styles.textInput}
              value={artist}
              onChangeText={setArtist}
              placeholder="アーティスト名を入力"
              placeholderTextColor="#A09DA1"
            />
          </View>
        </View>

        <TouchableOpacity
          style={[styles.uploadButton, { opacity: isUploading ? 0.6 : 1 }]}
          onPress={uploadAudio}
          disabled={isUploading}
        >
          <MaterialIcons name="upload" size={24} color="#fff" />
          <Text style={styles.uploadButtonText}>
            {isUploading ? 'アップロード中...' : 'アップロード'}
          </Text>
        </TouchableOpacity>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#E5E2E9',
  },
  content: {
    flex: 1,
    paddingHorizontal: 24,
    paddingTop: 16,
  },
  uploadArea: {
    backgroundColor: '#fff',
    borderRadius: 24,
    padding: 24,
    marginBottom: 24,
    shadowColor: '#191217',
    shadowOpacity: 0.08,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 4 },
    elevation: 4,
  },
  filePickerButton: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 32,
    borderWidth: 2,
    borderColor: '#CB759E',
    borderStyle: 'dashed',
    borderRadius: 16,
  },
  filePickerButtonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#CB759E',
    marginTop: 8,
  },
  filePickerSubText: {
    fontSize: 14,
    color: '#A09DA1',
    marginTop: 4,
  },
  selectedFileInfo: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F5F3F7',
    padding: 16,
    borderRadius: 12,
    marginTop: 16,
  },
  fileInfo: {
    flex: 1,
    marginLeft: 12,
  },
  fileName: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#191217',
  },
  fileSize: {
    fontSize: 14,
    color: '#A09DA1',
    marginTop: 2,
  },
  removeButton: {
    padding: 8,
  },
  formSection: {
    backgroundColor: '#fff',
    borderRadius: 24,
    padding: 24,
    marginBottom: 24,
    shadowColor: '#191217',
    shadowOpacity: 0.08,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 4 },
    elevation: 4,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#191217',
    marginBottom: 16,
  },
  inputContainer: {
    marginBottom: 16,
  },
  inputLabel: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#191217',
    marginBottom: 8,
  },
  textInput: {
    borderWidth: 1,
    borderColor: '#E5E2E9',
    borderRadius: 12,
    padding: 16,
    fontSize: 16,
    color: '#191217',
    backgroundColor: '#F5F3F7',
  },
  uploadButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#CB759E',
    borderRadius: 16,
    paddingVertical: 16,
    paddingHorizontal: 24,
    marginBottom: 32,
  },
  uploadButtonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff',
    marginLeft: 8,
  },
});