//
//  BLActivitySetting.m
//  BlueCat
//
//  Created by Tony on 2022/8/7.
//

#import <UIKit/UIKit.h>
#import "BLActivitySetting.h"

#define kLastPath @"BLActivitySetting"

@implementation BLActivitySetting

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeBool:self.autoMode forKey:@"autoMode"];
    
    [coder encodeFloat:self.captureW forKey:@"captureW"];
    [coder encodeFloat:self.captureH forKey:@"captureH"];
    
    [coder encodeObject:self.mainImage forKey:@"mainImage"];
    [coder encodeObject:self.captureImage forKey:@"captureImage"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _autoMode = [coder decodeBoolForKey:@"autoMode"];
        
        _captureW = [coder decodeFloatForKey:@"captureW"];
        _captureH = [coder decodeFloatForKey:@"captureH"];
        
        _mainImage = [coder decodeObjectForKey:@"mainImage"];
        _captureImage = [coder decodeObjectForKey:@"captureImage"];
    }
    return self;
}

- (void)setAutoMode:(BOOL)autoMode {
    _autoMode = autoMode;
    [BLActivitySetting saveActivitySetting:self];
}

- (void)setCaptureW:(CGFloat)captureW {
    if (captureW > 0 && captureW < kSCREEN_WIDTH) {
        _captureW = captureW;
        [BLActivitySetting saveActivitySetting:self];
    }
}

- (void)setCaptureH:(CGFloat)captureH {
    if (captureH > 0 && captureH < kSCREEN_HEIGHT) {
        _captureH = captureH;
        [BLActivitySetting saveActivitySetting:self];
    }
}

- (void)setMainImage:(NSString *)mainImage {
    if ([BLActivitySetting checkImage:mainImage]) {
        _mainImage = mainImage;
        [BLActivitySetting saveActivitySetting:self];
    }
}

- (void)setCaptureImage:(NSString *)captureImage {
    if ([BLActivitySetting checkImage:captureImage]) {
        _captureImage = captureImage;
        [BLActivitySetting saveActivitySetting:self];
    }
}


+ (BOOL)checkImage:(NSString *)name {
    BOOL checkOK = NO;
    UIImage * backImage = [UIImage imageNamed:name];
    if (!backImage) {
        NSString *path = [kDocument stringByAppendingPathComponent:name];
        NSData *imageData = [NSData dataWithContentsOfFile:path];
        backImage = [UIImage imageWithData:imageData];
    }
    
    if (backImage) {
        checkOK = YES;
    }
    
    return checkOK;
}



+ (BOOL)saveActivitySetting:(BLActivitySetting *)activitySetting {
    if (!activitySetting) {
        return NO;
    }
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kLastPath];
    return [NSKeyedArchiver archiveRootObject:activitySetting toFile:path];
}

+ (nullable BLActivitySetting *)getActivitySetting {
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kLastPath];
    
    BLActivitySetting *setting = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!setting) {
        setting = [BLActivitySetting initSaveActivitySettingIfNullSetting];
    }
    return setting;
}


+ (BLActivitySetting *)initSaveActivitySettingIfNullSetting {
    BLActivitySetting *setting = [[BLActivitySetting alloc] init];
    setting.captureW = 80;
    setting.captureH = 80;
    
    setting.mainImage = @"footballField";
    setting.captureImage = @"football";
    
    [BLActivitySetting saveActivitySetting:setting];
    return setting;
}

@end
