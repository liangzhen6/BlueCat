//
//  BLActivityManager.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLActivityManager.h"
#import "BLMainPlayView.h"
#import "BLCaptureView.h"
#import "BLCaptureRouteModel.h"
#import "BLActivitySetting.h"

typedef NS_ENUM(NSUInteger, TimerActionType) {
    TimerActionTypeuUnknown = 0,
    TimerActionTypeRecord,
    TimerActionTypePlay
};


@interface BLActivityManager ()<CaptureViewChangeDelegate>
@property (nonatomic, readwrite) BLMainPlayView *mainPlayView;
@property (nonatomic, readwrite) BLActivitySetting *setting;

@property (nonatomic, strong) NSTimer *tickTimer;
@property (nonatomic, strong) NSMutableArray * sourceDataM;

@property (nonatomic, assign) TimerActionType timerType;

@property (nonatomic, assign) BOOL canDrag;
@property (nonatomic, assign) BOOL canRecord;
@property (nonatomic, assign) NSInteger count;

@end

static BLActivityManager * _manager;
@implementation BLActivityManager

+ (BLActivityManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[BLActivityManager alloc] init];
        [_manager buildSetting];
    });
    return _manager;
}

- (void)buildSetting {
    self.setting = [BLActivitySetting getActivitySetting];
}

- (void)buildMainPlayView {
    CGFloat captureViewW = self.setting.captureW;
    CGFloat captureViewH = self.setting.captureH;
    BLCaptureView *captureView = [[BLCaptureView alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - captureViewW)/2, (kSCREEN_HEIGHT - captureViewH)/2, captureViewW, captureViewH)];
    [captureView buildViewWithBackImageName:self.setting.captureImage];
    
    BLMainPlayView *mainPlayView = [[BLMainPlayView alloc] initWithFrame:kScreenRect];
    mainPlayView.delegate = self;
    [mainPlayView buildViewWith:captureView backImageName:self.setting.mainImage];
    
    self.mainPlayView = mainPlayView;
    
    self.canDrag = YES;
}

- (void)dectoryMainPlayView {
    [self tickTimerStart:NO];
    self.mainPlayView = nil;
}




#pragma mark --CaptureViewChangeDelegate
- (void)captureViewChangeOriginCenter:(CGPoint)center translation:(CGPoint)translation {
    if (!self.canDrag) {
        return;
    }
    
    double angle = 0;
//    if (fabs(translation.y) >= fabs(translation.x)) {
//        if (translation.y >= 0) {
//            angle = M_PI;
//        } else {
//            angle = 0;
//        }
//    } else {
//        if (translation.x >= 0) {
//            angle = M_PI_2;
//        } else {
//            angle = M_PI_2 + M_PI;
//        }
//    }
    
    
    if (translation.x < 0) {
        angle = 0;
    }
    
    if (translation.x > 0) {
        angle = M_PI;
    }
    
    CGFloat centerX = center.x + translation.x;
    CGFloat centerY = center.y + translation.y;
    CGPoint newCenter = CGPointMake(centerX, centerY);
    
    if (CGPointEqualToPoint(CGPointZero, translation)) {
        return;
    }
    
    NSLog(@"ange:%f*****%f*****%f", angle, translation.x, translation.y);

    [self.mainPlayView updateCaptureViewCenter:newCenter angle:angle];
    

    if (self.canRecord) {
        [self recordCenter:newCenter angle:angle];
    }
    
}

- (void)captureViewDragStateChange:(CaptureViewDragState)state {
    if (self.setting.autoMode) {
        if (state == CaptureViewDragStateBegin) {
            [self.sourceDataM removeAllObjects];
            self.timerType = TimerActionTypeRecord;
            self.canRecord = YES;
            self.canDrag = YES;
            [self tickTimerStart:YES];
            
        } else if (state == CaptureViewDragStateEnd) {
            self.timerType = TimerActionTypePlay;
            self.canRecord = NO;
            self.canDrag = NO;
            [self tickTimerStart:YES];
            self.count = - 1;
        }
    }
}



- (void)recordCenter:(CGPoint)center angle:(double)angle {
    BLCaptureRouteModel *model = [BLCaptureRouteModel createModelCenter:center angle:angle];
    [self.sourceDataM addObject:model];
    
    self.canRecord = NO;
}



- (void)tickTimerAction {
    
    if (self.timerType == TimerActionTypeRecord) {
        // 录制
        self.canRecord = YES;
    } else if (self.timerType == TimerActionTypePlay) {
        BLCaptureRouteModel *model = nil;
        self.count += 1;
        
        if (self.count < self.sourceDataM.count - 1) {
            model = self.sourceDataM[self.count];
        } else {
            self.count = -1;
        }
        
        if (model) {
            [self.mainPlayView updateCaptureViewCenter:model.center angle:model.angle];
        }
    }
    
}

- (void)tickTimerStart:(BOOL)start {
    if (start) {
        self.tickTimer.fireDate = [NSDate distantPast];
    } else {
        self.tickTimer.fireDate = [NSDate distantFuture];
    }
    
}


- (NSTimer *)tickTimer {
    if (_tickTimer == nil) {
        _tickTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(tickTimerAction) userInfo:nil repeats:YES];
        _tickTimer.fireDate = [NSDate distantFuture];
        [[NSRunLoop mainRunLoop] addTimer:_tickTimer forMode:NSRunLoopCommonModes];
    }
    return _tickTimer;
}


- (NSMutableArray *)sourceDataM {
    if (_sourceDataM == nil) {
        _sourceDataM = [[NSMutableArray alloc] init];
    }
    return _sourceDataM;
}




@end
