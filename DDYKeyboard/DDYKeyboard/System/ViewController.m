#import "ViewController.h"
#import "DDYMacrol.h"
#import "DDYCategoryHeader.h"
#import "DDYKeyboardView.h"

#ifndef DDYTopH
#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#endif


@interface ViewController ()

@property (nonatomic, strong) DDYKeyboardView *keyboardView;

@end

@implementation ViewController

- (DDYKeyboardView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [DDYKeyboardView keyboardTypeQQAllState:DDYKeyboardStateQuickSingle];
        _keyboardView.frame = CGRectMake(0, self.view.ddy_H - _keyboardView.ddy_H - DDYSafeInsets(self.view).bottom, DDYSCREENW, _keyboardView.ddy_H);
    }
    return _keyboardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // [<_UITileLayer: 0x0000> display]: Ignoring bogus layer size
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.keyboardView];
}


@end
