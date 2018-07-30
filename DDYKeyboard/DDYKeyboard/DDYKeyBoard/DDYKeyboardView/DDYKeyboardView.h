#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDYKeyboardType) {
    DDYKeyboardTypeQQ = 0,      // 仿QQ键盘
    DDYKeyboardTypeWechat,      // 仿微信键盘
};

typedef NS_ENUM(NSInteger, DDYKeyboardState) {
    DDYKeyboardStateNone = 0,    // 注销状态
    DDYKeyboardStateSystem,      // 系统键盘
    DDYKeyboardStateVoice,       // 声音状态
    DDYKeyboardStatePhoto,       // 相册状态
    DDYKeyboardStateVideo,       // 相机状态
    DDYKeyboardStateShake,       // 窗口抖动
    DDYKeyboardStateGif,         // gif状态
    DDYKeyboardStateRedEnvelope, // 红包模式
    DDYKeyboardStateEmoji,       // 表情模式
    DDYKeyboardStateMore,        // 更多模式
};

@interface DDYKeyboardView : UIView

@property (nonatomic, assign, readonly) DDYKeyboardState keyboardState;

+ (instancetype)keyboardWithType:(DDYKeyboardType)type;

- (void)changeKeyboardState:(DDYKeyboardState)state;

@end
