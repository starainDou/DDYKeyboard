#import "DDYShakeView.h"
#import "DDYKeyboardConfig.h"

@implementation DDYShakeView

+ (instancetype)viewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 测试颜色
        self.backgroundColor = DDYRandomColor;
    }
    return self;
}

- (void)shakeWarning {
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    frameAnimation.values = @[@(-5),@(-10),@(-15),@(-20),@(-25),@(-20),@(-15),@(-10),@(-5),@(0)];
    frameAnimation.duration = 0.5f;
    frameAnimation.repeatCount = 2;
    frameAnimation.removedOnCompletion = YES;
    for (UIView *view in [UIApplication sharedApplication].windows) {
        if ([view isKindOfClass:[UIWindow class]] && (view.ddy_W == DDYSCREENW)) {
            [[(UIWindow *)view layer] addAnimation:frameAnimation forKey:@"shake"];
        }
    }
}

@end
