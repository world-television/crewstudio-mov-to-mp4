import { Platform } from 'react-native';

import MovToMp4Ios from './index.ios.js';
import MovToMp4Android from './index.android.js';

const MovToMp4 = Platform.OS === 'ios' ? MovToMp4Ios : MovToMp4Android;

export default MovToMp4;
