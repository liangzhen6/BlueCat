//
//  BLCaptureRouteModel.h
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLCaptureRouteModel : NSObject
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) double angle;


+ (BLCaptureRouteModel *)createModelCenter:(CGPoint)center angle:(double)angle;

@end

NS_ASSUME_NONNULL_END
