#import <UIKit/UIKit.h>

@interface DDYKeyboardTextView : UITextView

@property (nonatomic, copy) void (^sendBlock)(UITextView *textView);

+ (instancetype)textViewWithFrame:(CGRect)frame;

@end
