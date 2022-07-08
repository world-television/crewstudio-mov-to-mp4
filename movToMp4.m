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
    if (@available(iOS 13.0, *)) {
        return @{
            @"RNMov2Mp4ExportPreset": @{
                @"ExportPresetLowQuality": AVAssetExportPresetLowQuality,
                @"ExportPresetMediumQuality": AVAssetExportPresetMediumQuality,
                @"ExportPresetHighestQuality": AVAssetExportPresetHighestQuality,
                @"ExportPresetHEVCHighestQuality": AVAssetExportPresetHEVCHighestQuality,
                @"ExportPresetHEVCHighestQualityWithAlpha": AVAssetExportPresetHEVCHighestQualityWithAlpha,
                @"ExportPreset640x480": AVAssetExportPreset640x480,
                @"ExportPreset960x540": AVAssetExportPreset960x540,
                @"ExportPreset1280x720": AVAssetExportPreset1280x720,
                @"ExportPreset1920x1080": AVAssetExportPreset1920x1080,
                @"ExportPreset3840x2160": AVAssetExportPreset3840x2160,
            },
        };
    } else if (@available(iOS 11.0, *)) {
            return @{
                @"RNMov2Mp4ExportPreset": @{
                    @"ExportPresetLowQuality": AVAssetExportPresetLowQuality,
                    @"ExportPresetMediumQuality": AVAssetExportPresetMediumQuality,
                    @"ExportPresetHighestQuality": AVAssetExportPresetHighestQuality,
                    @"ExportPresetHEVCHighestQuality": AVAssetExportPresetHEVCHighestQuality,
                    @"ExportPresetHEVCHighestQualityWithAlpha": AVAssetExportPresetHEVCHighestQuality,
                    @"ExportPreset640x480": AVAssetExportPreset640x480,
                    @"ExportPreset960x540": AVAssetExportPreset960x540,
                    @"ExportPreset1280x720": AVAssetExportPreset1280x720,
                    @"ExportPreset1920x1080": AVAssetExportPreset1920x1080,
                    @"ExportPreset3840x2160": AVAssetExportPreset3840x2160,
                },
            };
    } else {
        return @{
            @"RNMov2Mp4ExportPreset": @{
                @"ExportPresetLowQuality": AVAssetExportPresetLowQuality,
                @"ExportPresetMediumQuality": AVAssetExportPresetMediumQuality,
                @"ExportPresetHighestQuality": AVAssetExportPresetHighestQuality,
                @"ExportPresetHEVCHighestQuality": AVAssetExportPresetHighestQuality,
                @"ExportPresetHEVCHighestQualityWithAlpha": AVAssetExportPresetHighestQuality,
                @"ExportPreset640x480": AVAssetExportPreset640x480,
                @"ExportPreset960x540": AVAssetExportPreset960x540,
                @"ExportPreset1280x720": AVAssetExportPreset1280x720,
                @"ExportPreset1920x1080": AVAssetExportPreset1920x1080,
                @"ExportPreset3840x2160": AVAssetExportPreset3840x2160,
            },
        };
    }
}

RCT_EXPORT_METHOD(convertMovToMp4: (NSString*)filename
                 toPath:(NSString*)outputPath
                 videoQuality:(NSString*) videoQuality
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject
                )
{
    
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
