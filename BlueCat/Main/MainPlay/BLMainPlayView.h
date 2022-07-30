//
//  BLMainPlayView.h
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLBaseView.h"
#import "BLCaptureView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CaptureViewDragState) {
    CaptureViewDragStateUnknown = 0,
    CaptureViewDragStateBegin,
    CaptureViewDragStateChange,
    CaptureViewDragStateEnd,
};

@protocol CaptureViewChangeDelegate <NSObject>

- (void)captureViewChangeOriginCenter:(CGPoint)center translation:(CGPoint)translation;

- (void)captureViewDragStateChange:(CaptureViewDragState)state;

@end



@interface BLMainPlayView : BLBaseView
@property (nonatomic, weak) id<CaptureViewChangeDelegate> delegate;

- (void)buildViewWith:(BLCaptureView *)captureView;

- (void)updateCaptureViewCenter:(CGPoint)center angle:(double)angle;

@end

NS_ASSUME_NONNULL_END
