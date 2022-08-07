//
//  BLActivitySetting.h
//  BlueCat
//
//  Created by Tony on 2022/8/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BLActivitySetting : NSObject<NSCoding>
@property (nonatomic, assign) BOOL autoMode;

@property (nonatomic, assign) CGFloat captureW;
@property (nonatomic, assign) CGFloat captureH;

@property (nonatomic, copy) NSString *mainImage;
@property (nonatomic, copy) NSString *captureImage;

+ (BOOL)saveActivitySetting:(BLActivitySetting *)activitySetting;

+ (nullable BLActivitySetting *)getActivitySetting;

@end

NS_ASSUME_NONNULL_END
