export type Track = {
  id: string;
  title: string;
  artist: string;
  artwork: any;
  file: any;
  duration?: string;
};

export const tracks: Track[] = [
  {
    id: '1',
    title: 'Sample Track',
    artist: 'Sample Artist',
    artwork: require('../assets/icon.png'),
    file: require('../assets/sample.mp3'),
    duration: '2:34',
  },
  // 追加のトラックはここに
];