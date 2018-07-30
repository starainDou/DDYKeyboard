#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDYKeyboardType) {
    DDYKeyboardTypeQQ = 0,      // 仿QQ键盘
    DDYKeyboardTypeWechat,      // 仿微信键盘
};

typedef NS_OPTIONS(NSInteger, DDYKeyboardState) {
    DDYKeyboardStateNone        = 0,        // 注销状态
    DDYKeyboardStateSystem      = 1 << 0,   // 系统键盘
    DDYKeyboardStateVoice       = 1 << 1,   // 声音状态
    DDYKeyboardStatePhoto       = 1 << 2,   // 相册状态
    DDYKeyboardStateVideo       = 1 << 3,   // 相机状态
    DDYKeyboardStateShake       = 1 << 4,   // 窗口抖动
    DDYKeyboardStateGif         = 1 << 5,   // gif状态
    DDYKeyboardStateRedEnvelope = 1 << 6,   // 红包模式
    DDYKeyboardStateEmoji       = 1 << 7,   // 表情模式
    DDYKeyboardStateMore        = 1 << 8,   // 更多模式
};

@interface DDYKeyboardView : UIView

@property (nonatomic, assign, readonly) DDYKeyboardState keyboardState;

+ (instancetype)keyboardWithType:(DDYKeyboardType)type allState:(DDYKeyboardState)allState;

@end
