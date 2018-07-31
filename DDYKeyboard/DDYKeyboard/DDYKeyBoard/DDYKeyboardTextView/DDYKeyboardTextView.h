#import <UIKit/UIKit.h>

@interface DDYKeyboardTextView : UIImageView

@property (nonatomic, copy) void (^autoHeightBlock)(CGFloat height);

@property (nonatomic, copy) void (^sendBlock)(UITextView *textView);

+ (instancetype)viewWithFrame:(CGRect)frame;

@end
