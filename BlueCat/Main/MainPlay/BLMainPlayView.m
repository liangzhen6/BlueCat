//
//  BLMainPlayView.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLMainPlayView.h"
#import "NSData+ImageContentType.h"
#import "UIImage+GIF.h"

@interface BLMainPlayView ()
@property (nonatomic, strong) BLCaptureView *captureView;
@property (nonatomic, assign) CaptureViewDragState state;
@property (nonatomic, strong) UIImageView *backImageView;
@end

@implementation BLMainPlayView

- (void)buildViewWith:(BLCaptureView *)captureView {
//    self.backgroundColor = [UIColor redColor];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    backImageView.image = [UIImage imageNamed:@"footballField"];
    [self addSubview:backImageView];
    self.backImageView = backImageView;
    
    [self addSubview:captureView];
    self.captureView = captureView;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewDidDrag:)];
    [captureView addGestureRecognizer:pan];
}

- (void)buildViewWith:(BLCaptureView *)captureView backImageName:(NSString *)name {
    [self buildViewWith:captureView];
    
    UIImage * backImage = [UIImage imageNamed:name];
    if (!backImage) {
        NSString *path = [kDocument stringByAppendingPathComponent:name];
        NSData *imageData = [NSData dataWithContentsOfFile:path];
        
        backImage = [UIImage sd_imageWithGIFData:imageData];
        if (!backImage) {
            backImage = [UIImage imageWithData:imageData];
        }
    }
    
    if (backImage) {
        self.backImageView.image = backImage;
    }
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
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeRotation(angle, 0, 1, 0);
    self.captureView.layer.transform = transform;
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
