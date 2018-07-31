#import "DDYPhotoView.h"
#import "DDYKeyboardConfig.h"

@implementation DDYPhotoView

+ (instancetype)voiceViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DDYRandomColor;
    }
    return self;
}

@end
