//
//  BLCaptureRouteModel.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLCaptureRouteModel.h"

@implementation BLCaptureRouteModel

+ (BLCaptureRouteModel *)createModelCenter:(CGPoint)center angle:(double)angle {
    BLCaptureRouteModel *model = [[BLCaptureRouteModel alloc] init];
    model.center = center;
    model.angle = angle;
    
    return model;
}

@end
