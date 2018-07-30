#import "DDYKeyboardView.h"

@implementation DDYKeyboardView

+ (instancetype)keyboardWithType:(DDYKeyboardType)type {
    return [[self alloc] initWithType:type];
}

- (instancetype)initWithType:(DDYKeyboardType)type {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - KeyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification {
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
}

- (void)changeKeyboardState:(DDYKeyboardState)state {
    if (self.keyboardState == state) {
        return;
    }
    
    switch (state) {
        case DDYKeyboardStateSystem:
        {
            
        }
            break;
        case DDYKeyboardStateVoice:
        {
            
        }
            break;
        case DDYKeyboardStatePhoto:
        {
            
        }
            break;
        case DDYKeyboardStateVideo:
        {
            
        }
            break;
        case DDYKeyboardStateGif:
        {
            
        }
            break;
        case DDYKeyboardStateShake:
        {
            
        }
            break;
        case DDYKeyboardStateRedEnvelope:
        {
            
        }
            break;
        case DDYKeyboardStateEmoji:
        {
            
        }
            break;
        case DDYKeyboardStateMore:
        {
            
        }
            break;
        case DDYKeyboardStateNone:
        default:
        {
            
        }
            break;
    }
}

@end
