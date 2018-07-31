#import "DDYKeyboardView.h"
#import "DDYKeyboardConfig.h"
#import "DDYKeyboardTextView.h"

static inline NSString *imgName(NSString *imgName) {return [NSString stringWithFormat:@"DDYKeyboard.bundle/%@", imgName];}

@interface DDYKeyboardView ()
/** 输入框 */
@property (nonatomic, strong) DDYKeyboardTextView *textView;

/** 语音按钮 */
@property (nonatomic, strong) UIButton *voiceButton;
/** 相册按钮 */
@property (nonatomic, strong) UIButton *photoButton;
/** 相机按钮 */
@property (nonatomic, strong) UIButton *videoButton;
/** 抖窗按钮 */
@property (nonatomic, strong) UIButton *shakeButton;
/** gif按钮 */
@property (nonatomic, strong) UIButton *gifButton;
/** 红包按钮 */
@property (nonatomic, strong) UIButton *redButton;
/** 表情按钮 */
@property (nonatomic, strong) UIButton *emojiButton;
/** 更多按钮 */
@property (nonatomic, strong) UIButton *moreButton;
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

/** 语音视图 */
@property (nonatomic, strong) UIView *voiceView;
/** 相册视图 */
@property (nonatomic, strong) UIView *photoView;
/** 相机视图 */
@property (nonatomic, strong) UIView *videoView;
/** 抖窗视图 */
@property (nonatomic, strong) UIView *shakeView;
/** gif视图 */
@property (nonatomic, strong) UIView *gifView;
/** 红包视图 */
@property (nonatomic, strong) UIView *redView;
/** 表情视图 */
@property (nonatomic, strong) UIView *emojiView;
/** 更多视图 */
@property (nonatomic, strong) UIView *moreView;
/** 键盘高度 */
@property (nonatomic, assign) CGFloat keyboardH;

@end

@implementation DDYKeyboardView

- (DDYKeyboardTextView *)textView {
    if (!_textView) {
        _textView = [DDYKeyboardTextView viewWithFrame:CGRectMake(kbTextViewMargin, kbTextViewTop, DDYSCREENW-2*kbTextViewMargin, kbTextViewH)];
        __weak __typeof (self)weakSelf = self;
        [_textView setAutoHeightBlock:^(CGFloat height) {
            __strong __typeof (weakSelf)strongSelf = weakSelf;
            [strongSelf layoutIfNeeded];
        }];
    }
    return _textView;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

+ (instancetype)keyboardTypeQQAllState:(DDYKeyboardState)allState {
    return [[self alloc] initWithAllState:allState];
}

- (instancetype)initWithAllState:(DDYKeyboardState)allState {
    if (self = [super init]) {
        [self addSubview:self.textView];
        [self layoutButtonWithAllState:allState];
        [self layoutIfNeeded];
        [self addNotification];
        self.backgroundColor = DDYRGBA(250., 250., 250., 1.);
    }
    return self;
}

#pragma mark 布局选择按钮
- (void)layoutButtonWithAllState:(DDYKeyboardState)allState {
    if (allState & DDYKeyboardStateVoice) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"voiceN") selectedImg:imgName(@"voiceS") tag:DDYKeyboardStateVoice]];
    }
    if (allState & DDYKeyboardStatePhoto) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"photoN") selectedImg:imgName(@"photoS") tag:DDYKeyboardStatePhoto]];
    }
    if (allState & DDYKeyboardStateVideo) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"videoN") selectedImg:imgName(@"videoS") tag:DDYKeyboardStateVideo]];
    }
    if (allState & DDYKeyboardStateShake) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"shakeN") selectedImg:imgName(@"shakeS") tag:DDYKeyboardStateShake]];
    }
    if (allState & DDYKeyboardStateGif) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"gifN") selectedImg:imgName(@"gifS") tag:DDYKeyboardStateGif]];
    }
    if (allState & DDYKeyboardStateRed) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"redN") selectedImg:imgName(@"redS") tag:DDYKeyboardStateRed]];
    }
    if (allState & DDYKeyboardStateEmoji) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"emojiN") selectedImg:imgName(@"emojiS") tag:DDYKeyboardStateEmoji]];
    }
    if (allState & DDYKeyboardStateMore) {
        [self.buttonArray addObject:[self buttonImg:imgName(@"moreN") selectedImg:imgName(@"moreS") tag:DDYKeyboardStateMore]];
    }
}

- (UIButton *)buttonImg:(NSString *)img selectedImg:(NSString *)imgS tag:(NSUInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgS] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(handleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [self addSubview:button];
    return button;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - KeyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardH = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.ddy_Bottom = CGRectGetHeight(self.superview.bounds) - keyboardH;
    } completion:^(BOOL finished) {
        self.keyboardH = keyboardH;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.ddy_Bottom = self.superview.ddy_H - DDYSafeInsets(self.superview).bottom;
    } completion:^(BOOL finished) {
        self.keyboardH = 0;
    }];
}

- (void)changeKeyboardState:(DDYKeyboardState)state {
    if (self.keyboardState == state) {
        return;
    }
    
    switch (state) {
        case DDYKeyboardStateSystem:
        {
            
        }
            break;
        case DDYKeyboardStateVoice:
        {
            
        }
            break;
        case DDYKeyboardStatePhoto:
        {
            
        }
            break;
        case DDYKeyboardStateVideo:
        {
            
        }
            break;
        case DDYKeyboardStateGif:
        {
            
        }
            break;
        case DDYKeyboardStateShake:
        {
            
        }
            break;
        case DDYKeyboardStateRed:
        {
            
        }
            break;
        case DDYKeyboardStateEmoji:
        {
            
        }
            break;
        case DDYKeyboardStateMore:
        {
            
        }
            break;
        case DDYKeyboardStateNone:
        default:
        {
            
        }
            break;
    }
}

- (void)handleButtonClick:(UIButton *)button {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIButton *currentButton = nil;
    CGFloat buttonMargin = (DDYSCREENW - kbButtonWH * self.buttonArray.count) / (self.buttonArray.count + 1.);
    for (UIButton *button in self.buttonArray) {
        button.ddy_Top = self.textView.ddy_Bottom + kbButtonTop;
        button.ddy_Left = (currentButton ? currentButton.ddy_Right : 0) + buttonMargin;
        currentButton = button;
    }
    
    self.ddy_H = kbTextViewTop + self.textView.ddy_H + kbButtonTop + kbButtonWH + kbButtonBottom;
    if (self.superview) {
        self.ddy_Bottom = self.superview.ddy_H - (self.keyboardH == 0 ? DDYSafeInsets(self.superview).bottom : self.keyboardH);
    }
}

@end
