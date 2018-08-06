#import <UIKit/UIKit.h>

@interface DDYVoiceIndicator : UIView

+ (instancetype)indicatorWithFrame:(CGRect)frame;

- (void)scrollToIndex:(NSInteger)index;

@end
