#import <UIKit/UIKit.h>

@interface DDYPhotoView : UIView

@property (nonatomic, copy) void (^sendImagesBlock)(NSArray<UIImage *> *imgArray, BOOL isOrignal);

+ (instancetype)voiceViewWithFrame:(CGRect)frame;

- (void)reset;

@end
