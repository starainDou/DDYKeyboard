#import "DDYMacrol.h"
#import "DDYCategoryHeader.h"

// 背景色
#define kbBgSmallColor [UIColor colorWithRed:245./255. green:245./255. blue:245./255. alpha:1.]
#define kbBgMidColor [UIColor colorWithRed:235./255. green:235./255. blue:235./255. alpha:1.]
#define kbBgBigColor [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.]
// 字体色
#define kbTextColor [UIColor colorWithRed:0. green:100./255. blue:1. alpha:1.]

// 输入框字号
#define kbTextViewFont 15
// 输入框距顶部距离
#define kbTextViewTop 10
// 输入框距左右距离
#define kbTextViewMargin 10
// 输入框默认高度
#define kbTextViewH 30
// 按钮宽高
#define kbButtonWH 30
// 按钮距输入框距离
#define kbButtonTop 20
// 按钮距底部距离
#define kbButtonBottom 10
// 常驻bar高度自动计算 H kbTextViewTop + 输入框高度(可变) + buttonTop + buttonWH + buttonBottom
// 常驻bar默认高度 kbTextViewTop + kbTextViewH + kbButtonTop + kbButtonWH + kbButtonBottom = 10+30+20+30+10

// 功能实现区域(textView.inputView)高度
#define kbInputViewH 260

/** 语音 */
// 首页面指示器圆点高宽
#define kbVoiceCircleWH 8
// 首页面指示器文字标签距圆点距离
#define kbVoiceLabalTop 6
// 首页面指示器文字标签高度
#define kbVoiceLabalH 16
// 首页面指示器文字标签间距
#define kbVoiceLabalMargin 10
// 首页面指示器文字标签字号
#define kbVoiceLabalFont 14
// 首页面指示器文字标签距底部边缘距离
#define kbVoiceLabalBottom 20
// 整个指示条高度
#define kbVoiceIndicatorH kbVoiceCircleWH + kbVoiceLabalTop + kbVoiceLabalH + kbVoiceLabalBottom

// 状态
typedef NS_ENUM(NSInteger, DDYVoiceState) {
    DDYVoiceStatePrepare = 0,       // 准备中
    DDYVoiceStateNormal,            // 按住说话
    DDYVoiceStateClickRecord,       // 点击录音
    DDYVoiceStateTouchChangeVoice,  // 按住变声
    DDYVoiceStateListen,            // 试听
    DDYVoiceStateCancel,            // 取消
    DDYVoiceStateSend,              // 发送
    DDYVoiceStateRecording,         // 录音中
    DDYVoiceStatePreparePlay,       // 准备播放
    DDYVoiceStatePlay,              // 播放
};

/** 相册 */
// 字体大小
#define kbPhotoFont 16

