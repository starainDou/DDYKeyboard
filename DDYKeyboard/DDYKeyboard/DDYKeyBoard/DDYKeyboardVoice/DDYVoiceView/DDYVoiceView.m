#import "DDYVoiceView.h"
#import "DDYVoiceIndicator.h"
#import "DDYKeyboardConfig.h"
#import "DDYVoiceChangeView.h"
#import "DDYVoiceTalkView.h"
#import "DDYVoiceRecordView.h"

@interface DDYVoiceView ()<UIScrollViewDelegate>
/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 变声视图 */
@property (nonatomic, strong) DDYVoiceChangeView *changeView;
/** 对讲视图 */
@property (nonatomic, strong) DDYVoiceTalkView *talkView;
/** 录音视图 */
@property (nonatomic, strong) DDYVoiceRecordView *recordView;
/** 标签视图 */
@property (nonatomic, strong) DDYVoiceIndicator *indicatorView;
/** 播放视图 */

@end

@implementation DDYVoiceView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.ddy_W, self.ddy_H)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.ddy_W * 3, self.ddy_H);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}




- (DDYVoiceIndicator *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [DDYVoiceIndicator indicatorWithFrame:CGRectMake(0, self.ddy_H-kbVoiceIndicatorH, self.ddy_W, kbVoiceIndicatorH)];
    }
    return _indicatorView;
}

- (UILabel *)labelTitle:(NSString *)title tag:(NSInteger)tag {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, kbVoiceLabalH)];
    [label setText:title];
    [label setFont:[UIFont systemFontOfSize:kbVoiceLabalFont]];
    [label setTextColor:DDY_Mid_Black];
    [label sizeToFit];
    [label setTag:tag];
    return label;
}

+ (instancetype)voiceViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 滚动视图
        [self addSubview:self.scrollView];
        
        // 标签指示
        [self addSubview:self.indicatorView];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_indicatorView scrollToIndex:(scrollView.contentOffset.x +  scrollView.ddy_W/2) / scrollView.ddy_W];
}

@end
