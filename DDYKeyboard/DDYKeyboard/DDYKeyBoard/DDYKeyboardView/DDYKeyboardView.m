#import "DDYKeyboardView.h"
#import "DDYKeyboardConfig.h"

static inline NSString *imgName(NSString *imgName) {return [NSString stringWithFormat:@"DDYKeyboard.bundle/%@", imgName];}

@interface DDYKeyboardView ()
/** 输入框 */
@property (nonatomic, strong) UITextView *textView;
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

@end

@implementation DDYKeyboardView

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

+ (instancetype)keyboardWithType:(DDYKeyboardType)type allState:(DDYKeyboardState)allState {
    return [[self alloc] initWithType:type allState:allState];
}

- (instancetype)initWithType:(DDYKeyboardType)type allState:(DDYKeyboardState)allState {
    if (self = [super init]) {
        
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
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
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
    CGFloat buttonMargin = (DDYSCREENW - kbBarButtonWH * self.buttonArray.count) / (self.buttonArray.count + 1.);
    for (UIButton *button in self.buttonArray) {
        button.ddy_Top = self.textView.ddy_Bottom + kbBarButtonTop;
        button.ddy_Left = (currentButton ? currentButton.ddy_Right : 0) + buttonMargin;
        currentButton = button;
    }
}

@end
