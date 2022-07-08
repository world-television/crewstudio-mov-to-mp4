#import "movToMp4.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation movToMp4

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
  return @{
    @"RNMov2Mp4ExportPreset": @{
      @"ExportPresetLowQuality": @(ExportPresetLowQuality),
      @"ExportPresetMediumQuality": @(ExportPresetMediumQuality),
      @"ExportPresetHighestQuality": @(ExportPresetHighestQuality),
      @"ExportPresetHEVCHighestQuality": @(ExportPresetHEVCHighestQuality),
      @"ExportPresetHEVCHighestQualityWithAlpha": @(ExportPresetHEVCHighestQualityWithAlpha),
      @"ExportPreset640x480": @(ExportPreset640x480),
      @"ExportPreset960x540": @(ExportPreset960x540),
      @"ExportPreset1280x720": @(ExportPreset1280x720),
      @"ExportPreset1920x1080": @(ExportPreset1920x1080),
      @"ExportPreset3840x2160": @(ExportPreset3840x2160),
    },
  };
}

RCT_EXPORT_METHOD(convertMovToMp4: (NSString*)filename
                 toPath:(NSString*)outputPath
                 quality:(NSInteger) quality
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject
                )
{
    
    NSString* videoQuality = nil;
    
    switch (quality) {
      case ExportPresetLowQuality:
            videoQuality = AVAssetExportPresetLowQuality;
            break;
      case ExportPresetMediumQuality:
            videoQuality = AVAssetExportPresetMediumQuality;
            break;
      case ExportPresetHighestQuality:
            videoQuality = AVAssetExportPresetHighestQuality;
            break;
      case ExportPresetHEVCHighestQuality:
            if (@available(iOS 11.0, *)) {
                videoQuality = AVAssetExportPresetHEVCHighestQuality;
            } else {
                // Fallback on earlier versions
                videoQuality = AVAssetExportPresetHighestQuality;
            }
            break;
      case ExportPresetHEVCHighestQualityWithAlpha:
            if (@available(iOS 13.0, *)) {
                videoQuality = AVAssetExportPresetHEVCHighestQualityWithAlpha;
            } else {
                // Fallback on earlier versions
                videoQuality = AVAssetExportPresetHighestQuality;
            }
            break;
      case ExportPreset640x480:
            videoQuality = AVAssetExportPreset640x480;
            break;
      case ExportPreset960x540:
            videoQuality = AVAssetExportPreset960x540;
            break;
      case ExportPreset1280x720:
            videoQuality = AVAssetExportPreset1280x720;
            break;
      case ExportPreset1920x1080:
            videoQuality = AVAssetExportPreset1920x1080;
            break;
      case ExportPreset3840x2160:
            videoQuality = AVAssetExportPreset3840x2160;
            break;
      default:
            videoQuality = AVAssetExportPresetHighestQuality;
    }
    
    NSURL *urlFile = [NSURL fileURLWithPath:filename];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlFile options:nil];

    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];

    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:videoQuality];

    NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.mp4", outputPath];

    exportSession.outputURL = [NSURL fileURLWithPath:resultPath];

    //set the output file format if you want to make it in other file format (ex .3gp)
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;

    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status])
        {
            case AVAssetExportSessionStatusFailed: {
                NSError* error = exportSession.error;
                NSString *codeWithDomain = [NSString stringWithFormat:@"E%@%zd", error.domain.uppercaseString, error.code];
                reject(codeWithDomain, error.localizedDescription, error);
                break;
            }
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"Export canceled");
                break;
            case AVAssetExportSessionStatusCompleted:
            {
                //Video conversion finished
                //NSLog(@"Successful!");
                resolve(resultPath);
            }
                break;
            default:
                break;
        }
    }];


}

@end