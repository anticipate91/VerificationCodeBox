//
//  ViewController.m
//  VerificationCodeBox
//
//  GitHub主页: https://github.com/jinht
//  CSDN博客: http://blog.csdn.net/anticipate91
//
//  Created by Jht on 2017/7/19.
//  Copyright © 2017年 Jinht. All rights reserved.
//

#import "ViewController.h"
#import "JhtVerificationCodeView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}



#pragma mark - UI
/** 创建UI界面 */
- (void)createUI {
    for (NSInteger i = 0; i < 2; i ++) {
        JhtVerificationCodeView *verificationCodeView = [[JhtVerificationCodeView alloc] initWithFrame:CGRectMake(40, 20 + 40 + 100 * i, CGRectGetWidth(self.view.frame) - 80, 60)];
        verificationCodeView.tag = 100 + i;
        
        switch (i) {
            case 0: {
                // 边框（每个格子的框）
                verificationCodeView.hasBoder = YES;
                verificationCodeView.boderColor = [UIColor redColor];
                // 输入风格
                verificationCodeView.codeViewType = JhtVerificationCodeViewType_Secret;
                
                break;
            }
                
            case 1: {
                // 下划线
                verificationCodeView.hasUnderLine = YES;
                verificationCodeView.underLineColor = [UIColor greenColor];
                verificationCodeView.isFlashing_NoInput = YES;
                // 输入风格
                verificationCodeView.codeViewType = JhtVerificationCodeViewType_Custom;
                
                break;
            }
                
            default:
                break;
        }
        
        //        verificationCodeView.backgroundColor = [UIColor redColor];
        verificationCodeView.endEditBlcok = ^(NSString *str) {
            NSLog(@"输入的验证码为：%@", str);
        };
        
        [self.view addSubview:verificationCodeView];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 170 - 10, CGRectGetMaxY(verificationCodeView.frame) + 5, 170, 30)];
        btn.tag = 200 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setBackgroundColor:[UIColor purpleColor]];
        [btn setTitle:@"改变所有已输入验证码的颜色" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        [self.view addSubview:btn];
        
        if (i == 1) {
            [verificationCodeView Jht_BecomeFirstResponder];
        }
    }
}

/** 点击@"改变所有已输入验证码的颜色"按钮触发方法 */
- (void)btnClick:(UIButton *)btn {
    JhtVerificationCodeView *view = [self.view viewWithTag:btn.tag - 100];
    UIColor *col = [UIColor orangeColor];;
    if (btn.tag % 2 == 0) {
        // 变色 && 震动 && 清空
        [view changeAllAlreadyInputTextColorWithColor:col hasShakeAndClear:YES];
    } else {
        // 变色
        [view changeAllAlreadyInputTextColorWithColor:col hasShakeAndClear:NO];
    }
}



#pragma mark - UIResponder
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    BOOL isEndEdit = NO;
    
    for (NSInteger i = 100; i < 102; i ++) {
        UIView *view = [self.view viewWithTag:i];
        CGPoint point2 = [view convertPoint:point fromView:self.view];
        
        if ([view.layer containsPoint:point2]) {
            isEndEdit = YES;
        }
    }
    
    if (!isEndEdit) {
        [self.view endEditing:YES];
    }
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
