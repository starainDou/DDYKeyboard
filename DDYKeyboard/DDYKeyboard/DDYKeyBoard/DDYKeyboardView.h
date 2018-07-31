#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDYKeyboardType) {
    DDYKeyboardTypeQQ = 0,      // 仿QQ键盘
    DDYKeyboardTypeWechat,      // 仿微信键盘
};

typedef NS_OPTIONS(NSInteger, DDYKeyboardState) {
    DDYKeyboardStateNone        = 0,        // 注销状态
    DDYKeyboardStateSystem      = 1 << 0,   // 系统键盘
    DDYKeyboardStateVoice       = 1 << 1,   // 语音状态
    DDYKeyboardStatePhoto       = 1 << 2,   // 相册状态
    DDYKeyboardStateVideo       = 1 << 3,   // 相机状态
    DDYKeyboardStateShake       = 1 << 4,   // 窗口抖动
    DDYKeyboardStateGif         = 1 << 5,   // gif状态
    DDYKeyboardStateRed         = 1 << 6,   // 红包模式
    DDYKeyboardStateEmoji       = 1 << 7,   // 表情模式
    DDYKeyboardStateMore        = 1 << 8,   // 更多模式
    DDYKeyboardStateQuickSingle = DDYKeyboardStateVoice | DDYKeyboardStatePhoto | DDYKeyboardStateVideo | DDYKeyboardStateShake |
                                  DDYKeyboardStateGif   | DDYKeyboardStateRed   | DDYKeyboardStateEmoji | DDYKeyboardStateMore,   // 单聊快速设置
    DDYKeyboardStateQuickGroup  = DDYKeyboardStateVoice | DDYKeyboardStatePhoto | DDYKeyboardStateVideo | DDYKeyboardStateGif   |
                                  DDYKeyboardStateRed   | DDYKeyboardStateEmoji | DDYKeyboardStateMore,   // 群聊快速设置
};

@interface DDYKeyboardView : UIView

@property (nonatomic, assign, readonly) DDYKeyboardState keyboardState;

+ (instancetype)keyboardTypeQQAllState:(DDYKeyboardState)allState;


@end