#import "ViewController.h"
#import "DDYMacrol.h"
#import "DDYCategoryHeader.h"
#import "DDYKeyboardView.h"
#import "Masonry.h"

#ifndef DDYTopH
#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#endif


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DDYKeyboardView *keyboardView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MessageCell"];
        [_tableView ddy_AddTapTarget:self action:@selector(handleTableViewTap)];
    }
    return _tableView;
}

- (DDYKeyboardView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [DDYKeyboardView keyboardTypeQQAllState:DDYKeyboardStateQuickSingle];
    }
    return _keyboardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // [<_UITileLayer: 0x0000> display]: Ignoring bogus layer size
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyboardView];
    [self setKeyboardBlock];
    
    
    self.tableView.backgroundColor = DDY_Red;
    self.keyboardView.backgroundColor = DDY_Blue;
    
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setKeyboardBlock {
    __weak __typeof (self)weakSelf = self;
    [_keyboardView setKeyboardShowAndHideBlock:^(CGFloat keyboardHeight) {
        __strong __typeof (weakSelf)strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.mas_equalTo(strongSelf.view);
                make.bottom.mas_equalTo(strongSelf.keyboardView.mas_top);
            }];
            NSLog(@"%@  %@ ", NSStringFromCGRect(self.tableView.frame), NSStringFromCGRect(self.keyboardView.frame));
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.keyboardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-DDYSafeInsets(self.view).bottom);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.keyboardView.mas_top);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试 test %ld",indexPath.row];
    return cell;
}

- (void)handleTableViewTap {
    [self.view endEditing:YES];
}


@end
