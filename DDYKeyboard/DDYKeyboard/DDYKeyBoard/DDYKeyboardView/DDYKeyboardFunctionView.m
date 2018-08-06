#import "DDYKeyboardFunctionView.h"

@implementation DDYKeyboardFunctionView

- (void)setInputView:(UIView *)inputView {
    if (_inputView) [_inputView removeFromSuperview];
    _inputView = inputView;
    if (_inputView) [self addSubview:inputView];
    _inputView.hidden = NO;
}

@end
