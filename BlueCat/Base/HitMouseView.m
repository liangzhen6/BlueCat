//
//  HitMouseView.m
//  BlueCat
//
//  Created by Tony on 2023/3/12.
//

#import "HitMouseView.h"


@interface HitMouseView ()
@property (nonatomic, strong) UIImageView *mouse;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) UIView *redPoint;
@end

@implementation HitMouseView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self readPointFlash];
    }
    return self;
}

- (void)setupUI {
    CGFloat width = self.frame.size.width;
    CGFloat hight = self.frame.size.height;

    
    UIImageView *topHole = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - 45, hight - 39, 88, 18)];
    topHole.image = [UIImage imageNamed:@"hole-top"];
    [self addSubview:topHole];
  
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(width/2 - 45, 0, 88, 125)];
    [self addSubview:backView];
    backView.clipsToBounds = YES;
    
    UIImageView *mouse = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 88, 125)];
    mouse.image = [UIImage imageNamed:@"mouse"];
    [backView addSubview:mouse];
    self.mouse = mouse;
    
    UIView *redPoint = [[UIView alloc] initWithFrame:CGRectMake((88-10)/2, 5, 10, 10)];
    redPoint.backgroundColor = [UIColor redColor];
    [mouse addSubview:redPoint];
    self.redPoint = redPoint;
    
    UIImageView *hole = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topHole.frame) - 11, 150, 32)];
    hole.image = [UIImage imageNamed:@"hole"];
    [self addSubview:hole];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self mouseMove];
}



- (void)readPointFlash {
    self.redPoint.hidden = !self.redPoint.hidden;
        
    [self performSelector:@selector(readPointFlash) withObject:nil afterDelay:0.2];
    
}


- (void)mouseMove {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(mouseMoveTohole) object:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.mouse.frame;
        if (frame.origin.y == 0) {
            frame.origin.y = 120;
            self.isShow = NO;
        } else {
            frame.origin.y = 0;
            self.isShow = YES;
        }
        self.mouse.frame = frame;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(mouseMoveTohole) withObject:nil afterDelay:2];
    }];
}

- (void)mouseMoveTohole {
    if (self.isShow) {
        [self mouseMove];
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
