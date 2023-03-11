//
//  BLActivityManager.h
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import <Foundation/Foundation.h>
#import "BLActivitySetting.h"

NS_ASSUME_NONNULL_BEGIN
@class BLMainPlayView, BLActivitySetting;
@interface BLActivityManager : NSObject
@property (nonatomic, readonly) BLMainPlayView *mainPlayView;
@property (nonatomic, readonly) BLActivitySetting *setting;

+ (BLActivityManager *)shareManager;

- (void)buildMainPlayView;

- (void)dectoryMainPlayView;

@end

NS_ASSUME_NONNULL_END
