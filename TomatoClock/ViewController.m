//
//  ViewController.m
//  TomatoClock
//
//  Created by 章立彬 on 2021/1/15.
//

#import "ViewController.h"
#import "NSString+TimeString.h"
#import <Masonry/Masonry.h>

#define mSelectButtonWidth 80.0
#define mSelectButtonHeight 44.0

@interface ViewController ()

@property (nonatomic, strong) NSArray<NSString *> *selectTimeArray;
@property (nonatomic, strong) NSMutableArray<UIButton *> *selectButtonArray;
@property (nonatomic, strong) UIView *clockView;
@property (nonatomic, strong) UILabel *countDownLabel;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, strong) NSString *selectMin;
@property (nonatomic, assign) NSInteger lastSecond;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
}

- (void)initData {
    _selectTimeArray = @[@"30", @"45", @"60"];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.clockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
        make.centerY.equalTo(self.view);
    }];
    
    [self.clockView addSubview:self.countDownLabel];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.clockView);
    }];
    
    [self.selectButtonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:mSelectButtonWidth leadSpacing:16.0 tailSpacing:16.0];
    
    [self.selectButtonArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clockView.mas_bottom);
        make.height.mas_equalTo(mSelectButtonHeight);
    }];
    
}

- (NSMutableArray<UIButton *> *)selectButtonArray {
    if (_selectButtonArray == nil) {
        _selectButtonArray = [NSMutableArray array];
        for (NSString *title in self.selectTimeArray) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            [_selectButtonArray addObject:button];
        }
    }
    return  _selectButtonArray;
}

- (UIView *)clockView {
    if (_clockView == nil) {
        _clockView = [[UIView alloc] init];
        _clockView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_clockView];
    }
    return _clockView;
}

- (UILabel *)countDownLabel {
    
    if (_countDownLabel == nil) {
        _countDownLabel = [[UILabel alloc] init];
        _countDownLabel.text = [NSString getDefaultFormatTimeWithSecond:0];
        _countDownLabel.font = [UIFont boldSystemFontOfSize:40];
        _countDownLabel.textColor = [UIColor darkGrayColor];
        _countDownLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countDownLabel;
}

- (NSTimer *)countDownTimer {
    if (_countDownTimer == nil) {
        _countDownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        //添加到CommonModes中，如果加入defaultModel中在出发其他类似拖动时会阻塞
        [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    }
    return _countDownTimer;
}

- (void)updateTimer:(NSTimer *)timer {
    
    if (self.lastSecond > 0) {
        self.lastSecond--;
    } else {
        [timer invalidate];
        timer = nil;
        return;
    }
    self.countDownLabel.text = [NSString getDefaultFormatTimeWithSecond:self.lastSecond];
}

- (void)setSelectMin:(NSString *)selectMin {
    _selectMin = selectMin;
    self.lastSecond = [selectMin integerValue] * 60;
    [self.countDownTimer fire];
}

- (void)buttonSelectAction:(UIButton *)button {
    NSLog(@"%@", button.titleLabel.text);
    self.selectMin = button.titleLabel.text;
}

@end
