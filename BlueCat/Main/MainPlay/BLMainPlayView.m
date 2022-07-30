//
//  BLMainPlayView.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLMainPlayView.h"

@interface BLMainPlayView ()
@property (nonatomic, strong) BLCaptureView *captureView;
@property (nonatomic, assign) CaptureViewDragState state;
@end

@implementation BLMainPlayView

- (void)buildViewWith:(BLCaptureView *)captureView {
    self.backgroundColor = [UIColor redColor];
    [self addSubview:captureView];
    
    self.captureView = captureView;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewDidDrag:)];
    [captureView addGestureRecognizer:pan];
}

- (void)dragViewDidDrag:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:self];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(captureViewChangeOriginCenter:translation:)]) {
        [self.delegate captureViewChangeOriginCenter:self.captureView.center translation:translation];
    }
    
    [pan setTranslation:CGPointZero inView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        // 开始了
        NSLog(@"开始了");
        [self changeState:CaptureViewDragStateBegin];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        NSLog(@"运行中");
        [self changeState:CaptureViewDragStateChange];
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        // 取消了
        NSLog(@"结束了");
        [self changeState:CaptureViewDragStateEnd];
    }
}

- (void)changeState:(CaptureViewDragState)state {
    if (self.state != state) {
        self.state = state;
        if (self.delegate && [self.delegate respondsToSelector:@selector(captureViewDragStateChange:)]) {
            [self.delegate captureViewDragStateChange:state];
        }
    }
}



- (void)updateCaptureViewCenter:(CGPoint)center angle:(double)angle {
    self.captureView.center = center;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, angle);
    self.captureView.transform = transform;
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
