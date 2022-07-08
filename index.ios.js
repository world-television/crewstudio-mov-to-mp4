/**
 * @providesModule movToMp4
 * @flow
 */
import { NativeModules } from 'react-native';

const NativemovToMp4 = NativeModules.movToMp4;

const constants = NativemovToMp4.getConstants();

const RNMov2Mp4ExportPreset = {
  ExportPresetLowQuality:
    constants.RNMov2Mp4ExportPreset.ExportPresetLowQuality,
  ExportPresetMediumQuality:
    constants.RNMov2Mp4ExportPreset.ExportPresetMediumQuality,
  ExportPresetHighestQuality:
    constants.RNMov2Mp4ExportPreset.ExportPresetHighestQuality,
  ExportPresetHEVCHighestQuality:
    constants.RNMov2Mp4ExportPreset.ExportPresetHEVCHighestQuality,
  ExportPresetHEVCHighestQualityWithAlpha:
    constants.RNMov2Mp4ExportPreset.ExportPresetHEVCHighestQualityWithAlpha,
  ExportPreset640x480: constants.RNMov2Mp4ExportPreset.ExportPreset640x480,
  ExportPreset960x540: constants.RNMov2Mp4ExportPreset.ExportPreset960x540,
  ExportPreset1280x720: constants.RNMov2Mp4ExportPreset.ExportPreset1280x720,
  ExportPreset1920x1080: constants.RNMov2Mp4ExportPreset.ExportPreset1920x1080,
  ExportPreset3840x2160: constants.RNMov2Mp4ExportPreset.ExportPreset3840x2160,
};

const movToMp4 = {
  RNMov2Mp4ExportPreset,
  convertMovToMp4: NativemovToMp4.convertMovToMp4,
};

export default movToMp4;
