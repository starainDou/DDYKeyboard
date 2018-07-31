#import "DDYVoiceIndicator.h"
#import "DDYKeyboardConfig.h"

@interface DDYVoiceIndicator ()
/** 圆点 */
@property (nonatomic, strong) UIView *circleView;
/** 标签容器 */
@property (nonatomic, strong) UIView *labelContainer;
/** 相对比例 */
@property (nonatomic, assign) CGFloat scale;

@end

@implementation DDYVoiceIndicator

- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(self.ddy_W/2.-kbVoiceCircleWH/2., 0, kbVoiceCircleWH, kbVoiceCircleWH)];
        _circleView.backgroundColor = [UIColor redColor];
        _circleView.layer.masksToBounds = YES;
        _circleView.layer.cornerRadius = kbVoiceCircleWH/2.;
    }
    return _circleView;
}

- (UIView *)labelContainer {
    if (!_labelContainer) {
        _labelContainer = [[UIView alloc] initWithFrame:CGRectMake(0, kbVoiceCircleWH, self.ddy_W, self.ddy_H - kbVoiceCircleWH)];
        
        UILabel *label1 = [self labelTitle:@"变声" tag:100 superView:_labelContainer];
        UILabel *label2 = [self labelTitle:@"对讲" tag:101 superView:_labelContainer];
        UILabel *label3 = [self labelTitle:@"录音" tag:102 superView:_labelContainer];
        label2.ddy_CenterX = self.ddy_W/2;
        label1.ddy_Right = label2.ddy_X - 10;
        label3.ddy_X = label2.ddy_Right + 10;
        // 相对比例
        _scale = (label2.ddy_CenterX-label1.ddy_CenterX)/self.ddy_W;
    }
    return _labelContainer;
}

+ (instancetype)indicatorWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 圆点指示
        [self addSubview:self.circleView];
        // 标签容器
        [self addSubview:self.labelContainer];
    }
    return self;
}

- (UILabel *)labelTitle:(NSString *)title tag:(NSInteger)tag superView:(UIView *)superView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, kbVoiceLabalH)];
    [label setText:title];
    [label setFont:[UIFont systemFontOfSize:kbVoiceLabalFont]];
    [label setTextColor:DDY_Mid_Black];
    [label sizeToFit];
    [label setTag:tag];
    [superView addSubview:label];
    return label;
}

- (void)scrollToIndex:(NSInteger)index {
    for (UILabel *label in self.labelContainer.subviews) {
        label.textColor = index==(label.tag-100) ? DDY_Red : DDY_Mid_Black;
    }
    self.labelContainer.transform = CGAffineTransformMakeTranslation((1-index)*self.ddy_W*self.scale, 0);
}

@end
