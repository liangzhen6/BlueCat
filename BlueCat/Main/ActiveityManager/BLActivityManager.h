//
//  BLActivityManager.h
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BLMainPlayView;
@interface BLActivityManager : NSObject
@property (nonatomic, readonly) BLMainPlayView *mainPlayView;

+ (BLActivityManager *)shareManager;

- (void)buildMainPlayView;

@end

NS_ASSUME_NONNULL_END
