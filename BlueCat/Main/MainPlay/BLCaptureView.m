//
//  BLCaptureView.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLCaptureView.h"

@implementation BLCaptureView

- (void)buildView {
    self.backgroundColor = [UIColor greenColor];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 10, 10)];
    headView.backgroundColor = [UIColor redColor];
    [self addSubview:headView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
