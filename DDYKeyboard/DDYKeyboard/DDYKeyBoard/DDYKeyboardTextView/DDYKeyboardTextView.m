#import "DDYKeyboardTextView.h"
#import "DDYKeyboardConfig.h"

@interface DDYKeyboardTextView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, assign) CGFloat orignalH;

@end

@implementation DDYKeyboardTextView

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.ddy_W, 20)];
        [_textView setFont:[UIFont systemFontOfSize:kbTextViewFont]];
        [_textView setTextContainerInset:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_textView setDelegate:self];
        [_textView setShowsVerticalScrollIndicator:NO];
        [_textView setShowsHorizontalScrollIndicator:NO];
        [_textView setBounces:NO];
        [_textView setBackgroundColor:[UIColor whiteColor]];
        [_textView setEnablesReturnKeyAutomatically:YES];
        
        [_textView setDdy_CenterY:self.ddy_H/2.];
        [_textView setPlaceholder:@"Test Message Placeholder"];
        [_textView setPlaceholderColor:[UIColor lightGrayColor]];
        [_textView ddy_AllowsNonContiguousLayout:NO];
        [_textView ddy_AutoHeightWithMinHeight:_textView.bounds.size.height maxHeight:80];
        
        // 防止图片表情误触
        if (@available(iOS 11.0, *)) {
            _textView.textDragInteraction.enabled = NO;
        }
        
        __weak __typeof (self)weakSelf = self;
        [_textView setAutoHeightBlock:^(CGFloat height) {
            __strong __typeof (weakSelf)strongSelf = weakSelf;
            [strongSelf setNeedsLayout];
            [strongSelf layoutIfNeeded];
        }];
    }
    return _textView;
}

+ (instancetype)viewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderColor = DDY_Small_Black.CGColor;
        self.layer.borderWidth = 0.6;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.orignalH = frame.size.height;
        
        [self addSubview:self.textView];
    }
    return self;
}

#pragma mark 私有方法
- (void)updateTextView {
    // 没有输入(输入全是空格)或者只拼音未输入完全状态
    if ([NSString ddy_blankString:self.textView.text] || [self.textView positionFromPosition:self.textView.markedTextRange.start offset:0]) return;
    
    NSRange selectedRange = self.textView.selectedRange;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.textView.text];
    
}

#pragma mark UITextViewDelegate
#pragma mark 处理发送
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([@"\n" isEqualToString:text]) {
        if (self.sendBlock) {
            self.sendBlock(textView);
        }
        return NO;
    }
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.textView.ddy_H + 6 > self.orignalH) {
        self.ddy_H = self.textView.ddy_H + 6;
    } else {
        self.ddy_H = self.orignalH;
    }
    if (self.autoHeightBlock) {
        self.autoHeightBlock(self.ddy_H);
    }
    
    self.textView.ddy_CenterY = self.ddy_H/2.;
}

@end
