//
//  BLCaptureView.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLCaptureView.h"
#import "NSData+ImageContentType.h"
#import "UIImage+GIF.h"

@interface BLCaptureView ()
@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation BLCaptureView

- (void)buildView {
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backImageView.contentMode = UIViewContentModeScaleToFill;
    backImageView.image = [UIImage imageNamed:@"football"];
    [self addSubview:backImageView];
    self.backImageView = backImageView;
}

- (void)buildViewWithBackImageName:(NSString *)name {
    [self buildView];
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
