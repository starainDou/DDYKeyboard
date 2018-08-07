#import "DDYKeyboard.h"
#import "DDYKeyboardTextBar.h"
#import "DDYKeyboardToolBar.h"
#import "DDYKeyboardFunctionView.h"
#import "DDYVoiceView.h"
#import "DDYPhotoView.h"
#import "DDYCameraController.h"
#import "DDYShakeView.h"
#import "DDYGifView.h"
#import "DDYRedBagView.h"
#import "DDYEmojiView.h"
#import "DDYMoreView.h"
#import "DDYAuthorityManager.h"

@interface DDYKeyboard ()
/** 顶部文本输入 */
@property (nonatomic, strong) DDYKeyboardTextBar *textBar;
/** 中部横排按钮 */
@property (nonatomic, strong) DDYKeyboardToolBar *toolBar;
/** 下部功能实现 */
@property (nonatomic, strong) DDYKeyboardFunctionView *functionView;
/** 键盘状态 */
@property (nonatomic, assign) DDYKeyboardState keyboardState;
/** 键盘高度 */
@property (nonatomic, assign) CGFloat keyboardH;
/** 语音视图 */
@property (nonatomic, strong) DDYVoiceView *voiceView;
/** 相册视图 */
@property (nonatomic, strong) DDYPhotoView *photoView;
/** 相机控制器 */
@property (nonatomic, strong) DDYCameraController *cameraViewController;
/** 抖窗视图 */
@property (nonatomic, strong) DDYShakeView *shakeView;
/** gif视图 */
@property (nonatomic, strong) DDYGifView *gifView;
/** 红包视图 */
@property (nonatomic, strong) DDYRedBagView *redBagView;
/** 表情视图 */
@property (nonatomic, strong) DDYEmojiView *emojiView;
/** 更多视图 */
@property (nonatomic, strong) DDYMoreView *moreView;
/** 功能区高度 */
@property (nonatomic, assign) CGFloat functionViewH;

@end

@implementation DDYKeyboard

- (DDYKeyboardTextBar *)textBar {
    if (!_textBar) {
        _textBar = [[DDYKeyboardTextBar alloc] init];
        [_textBar updateFrame];
        __weak __typeof (self)weakSelf = self;
        [_textBar setTextBarSendBlock:^(UITextView *textView) {
            
        }];
        [_textBar setTextBarChangeStatedBlock:^(DDYKeyboardState changedState) {
            __strong __typeof (weakSelf)strongSelf = weakSelf;
            [strongSelf changeKeyboardState:changedState];
        }];
        [_textBar setTextBarUpdateFrameBlock:^{
            __strong __typeof (weakSelf)strongSelf = weakSelf;
            [strongSelf updateFrameAnimate:NO];
        }];
    }
    return _textBar;
}

- (DDYKeyboardToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[DDYKeyboardToolBar alloc] init];
        __weak __typeof (self)weakSelf = self;
        [_toolBar setKeyboardStateChangedBlock:^(DDYKeyboardState changedState) {
            __strong __typeof (weakSelf)strongSelf = weakSelf;
            [strongSelf changeKeyboardState:changedState];
        }];
    }
    return _toolBar;
}

- (DDYKeyboardFunctionView *)functionView {
    if (!_functionView) {
        _functionView = [[DDYKeyboardFunctionView alloc] initWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
    }
    return _functionView;
}

- (DDYVoiceView *)voiceView {
    if (!_voiceView) {
        _voiceView = [DDYVoiceView viewWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
    }
    return _voiceView;
}

- (DDYPhotoView *)photoView {
    if (!_photoView) {
        _photoView = [DDYPhotoView viewWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
        [_photoView setAlbumBlock:^{
            NSLog(@"点击相册");
        }];
        [_photoView setEditBlock:^(UIImage *image) {
            NSLog(@"点击编辑");
        }];
        [_photoView setSendImagesBlock:^(NSArray<UIImage *> *imgArray, BOOL isOrignal) {
            NSLog(@"点击发送");
        }];
    }
    return _photoView;
}

- (DDYCameraController *)cameraViewController {
    if (!_cameraViewController) {
        _cameraViewController = [DDYCameraController new];
        [_cameraViewController setTakePhotoBlock:^(UIImage *image, UIViewController *vc) {
            [vc dismissViewControllerAnimated:YES completion:^{   }];
        }];
    }
    return _cameraViewController;
}

- (DDYShakeView *)shakeView {
    if (!_shakeView) {
        _shakeView = [DDYShakeView viewWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
    }
    return _shakeView;
}

- (DDYGifView *)gifView {
    if (!_gifView) {
        _gifView = [DDYGifView viewWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
    }
    return _gifView;
}

- (DDYRedBagView *)redBagView {
    if (!_redBagView) {
        _redBagView = [DDYRedBagView viewWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
    }
    return _redBagView;
}

- (DDYEmojiView *)emojiView {
    if (!_emojiView) {
        _emojiView = [DDYEmojiView viewWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
    }
    return _emojiView;
}

- (DDYMoreView *)moreView {
    if (!_moreView) {
        _moreView = [DDYMoreView viewWithFrame:CGRectMake(0, 0, DDYSCREENW, kbFunctionViewH)];
    }
    return _moreView;
}

+ (instancetype)keyboardWithType:(DDYKeyboardType)type {
    return [[self alloc] initWithType:type];
}

- (instancetype)initWithType:(DDYKeyboardType)type {
    if (self = [super initWithFrame:CGRectMake(0, DDYSCREENH, DDYSCREENW, 80)]) {
        [self addSubview:self.textBar];
        [self addSubview:self.toolBar];
        [self addSubview:self.functionView];
        [self setToolBarType:type];
        [self addNotification];
    }
    return self;
}

#pragma mark // 设置ToolBar
- (void)setToolBarType:(DDYKeyboardType)type {
    if (type == DDYKeyboardTypeStranger) {
        self.toolBar.allState = DDYKeyboardStateVoice | DDYKeyboardStatePhoto | DDYKeyboardStateVideo | DDYKeyboardStateGif |
        DDYKeyboardStateEmoji | DDYKeyboardStateMore;
    } else if (type == DDYKeyboardTypeSingle) {
        self.toolBar.allState = DDYKeyboardStateVoice | DDYKeyboardStatePhoto | DDYKeyboardStateVideo | DDYKeyboardStateShake |
        DDYKeyboardStateGif   | DDYKeyboardStateRedBag| DDYKeyboardStateEmoji | DDYKeyboardStateMore;
    } else if (type == DDYKeyboardTypeGroup) {
        self.toolBar.allState = DDYKeyboardStateVoice | DDYKeyboardStatePhoto | DDYKeyboardStateVideo | DDYKeyboardStateGif |
        DDYKeyboardStateRedBag| DDYKeyboardStateEmoji | DDYKeyboardStateMore;
    }
}

#pragma mark - 通知 Notification
#pragma mark 注册通知
- (void)addNotification {
    // 键盘将要弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    // 键盘将要收回通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark 键盘将要弹出通知响应
- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat keyboardH1 = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardH2 = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 键盘弹起可能存在多次回调
    if (keyboardH1 > 0) {
        self.keyboardH = keyboardH2;
        [self updateFrameAnimate:YES];
    }
}

#pragma mark 键盘将要收回通知响应
- (void)keyboardWillHide:(NSNotification *)notification {
    self.keyboardH = 0;
    // 三方键盘有的自带收回功能，所以要保证状态正确
    if (_keyboardState == DDYKeyboardStateSystem) {
        [self changeKeyboardState:DDYKeyboardStateNone];
    }
    [self updateFrameAnimate:YES];
}

#pragma mark 改变状态
// 如果自定义功能状态(!none && !system) 和 键盘收回状态(none) 相互切换时，则需要更新布局
- (void)changeKeyboardState:(DDYKeyboardState)state {
    
    void (^updateFrame)(BOOL) = ^(BOOL needUpdate) {
        needUpdate ? [self updateFrameAnimate:YES] : [self.textBar resignFirstResponder];
    };
    
    DDYKeyboardState originalState = _keyboardState;
    _keyboardState = state;
    switch (state) {
        case DDYKeyboardStateNone:
        {
            self.functionView.show = NO;
            [self.toolBar resetToolBarState];
            updateFrame(originalState != DDYKeyboardStateSystem);
        }
            break;
        case DDYKeyboardStateSystem:
        {
            self.functionView.show = NO;
            [self.toolBar resetToolBarState];
        }
            break;
        case DDYKeyboardStateVoice:
        {
            self.functionView.show = YES;
            self.functionView.inputView = self.voiceView;
            updateFrame(originalState == DDYKeyboardStateNone);
        }
            break;
        case DDYKeyboardStatePhoto:
        {
            self.functionView.show = YES;
            self.functionView.inputView = self.photoView;
            updateFrame(originalState == DDYKeyboardStateNone);
        }
            break;
        case DDYKeyboardStateVideo:
        {
            _keyboardState = originalState;
            [self presentCameraViewController];
        }
            break;
        case DDYKeyboardStateShake:
        {
           self.functionView.show = YES;
            self.functionView.inputView = self.shakeView;
//            [DDYShakeView shakeWarning:YES];
            [DDYShakeView scaleWarning];
            updateFrame(originalState == DDYKeyboardStateNone);
        }
            break;
        case DDYKeyboardStateGif:
        {
           self.functionView.show = YES;
            self.functionView.inputView = self.gifView;
            updateFrame(originalState == DDYKeyboardStateNone);
        }
            break;
        case DDYKeyboardStateRedBag:
        {
            self.functionView.show = YES;
            self.functionView.inputView = self.redBagView;
            updateFrame(originalState == DDYKeyboardStateNone);
        }
            break;
        case DDYKeyboardStateEmoji:
        {
            self.functionView.show = YES;
            self.functionView.inputView = self.emojiView;
            updateFrame(originalState == DDYKeyboardStateNone);
        }
            break;
        case DDYKeyboardStateMore:
        {
            self.functionView.show = YES;
            self.functionView.inputView = self.moreView;
            updateFrame(originalState == DDYKeyboardStateNone);
        }
            break;
    }
}

- (void)presentCameraViewController {
    [DDYAuthorityManager ddy_AudioAuthAlertShow:YES success:^{
        [DDYAuthorityManager ddy_CameraAuthAlertShow:YES success:^{
            [[self ddy_GetResponderViewController] presentViewController:self.cameraViewController animated:YES completion:^{ }];
        } fail:^(AVAuthorizationStatus authStatus) { }];
    } fail:^(AVAuthorizationStatus authStatus) { }];
}

- (void)updateFrameAnimate:(BOOL)animate { NSLog(@"%@", NSStringFromCGRect(self.frame));
    [UIView animateWithDuration:animate ? 0.25 : 0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.functionView.inputView.alpha = self.functionView.show ? 1 : 0.1;
        self.textBar.frame = CGRectMake(0, 0, DDYSCREENW, self.textBar.ddy_H);
        self.toolBar.frame = CGRectMake(0, self.textBar.ddy_Bottom, DDYSCREENW, kbToolBarH);
        self.functionView.frame = CGRectMake(0, self.toolBar.ddy_Bottom, DDYSCREENW, self.functionView.show ? kbFunctionViewH : 0);
        self.ddy_H = self.textBar.ddy_H + self.toolBar.ddy_H + (self.functionView.show ? kbFunctionViewH : 0);
        self.ddy_Bottom = self.superview.ddy_H - (self.keyboardH>0 ? self.keyboardH : DDYSafeInsets(self.superview).bottom);
        self.associateTableView.ddy_H = self.ddy_Y;
    } completion:^(BOOL finished) { }];
}

- (void)keyboardDown {
    [self changeKeyboardState:DDYKeyboardStateNone];
}

@end
