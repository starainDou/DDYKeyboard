#import "DDYKeyboardTextView.h"
#import "DDYCategoryHeader.h"

@interface DDYKeyboardTextView()<UITextViewDelegate>

@end

@implementation DDYKeyboardTextView

+ (instancetype)textViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTextContainerInset:UIEdgeInsetsMake(2.5, 0, 2.5, 0)];
        [self setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self setDelegate:self];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setBounces:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setEnablesReturnKeyAutomatically:YES];
        
        [self setPlaceholder:@"Test Message Placeholder"];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [self ddy_AllowsNonContiguousLayout:NO];
        [self ddy_AutoHeightWithMinHeight:self.bounds.size.height maxHeight:80];
        
        // 防止图片表情误触
        if (@available(iOS 11.0, *)) {
            self.textDragInteraction.enabled = NO;
        }
    }
    return self;
}

#pragma mark 私有方法
- (void)updateTextView {
    // 没有输入(输入全是空格)或者只拼音未输入完全状态
    if ([NSString ddy_blankString:self.text] || [self positionFromPosition:self.markedTextRange.start offset:0]) return;
    
    NSRange selectedRange = self.selectedRange;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    
}

#pragma mark UITextViewDelegate
#pragma mark 处理发送
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([@"\n" isEqualToString:text]) {
        if (self.sendBlock) {
            self.sendBlock(self);
        }
        return NO;
    }
    
    return YES;
}


@end
