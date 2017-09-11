//
//  HHSearchBar.m
//  HH_自定搜索框
//
//  Created by maoziyue on 17/6/14.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSearchBar.h"

//#define Height (30)

@interface HHSearchBar ()<UITextFieldDelegate>




@end

@implementation HHSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initUI];
    }
    return self;
}


- (void)initUI
{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, (height - 18)/2 , 18, 18)];
    
    imageV.image = [UIImage imageNamed:@"SearchIcon"];
    
    [self addSubview:imageV];
    
    
    
    //
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.cancelBtn setImage:[UIImage imageNamed:@"Clear"] forState:UIControlStateNormal];
    
    self.cancelBtn.frame = CGRectMake(width - 20 - 10, (height - 18)/2, 18, 18);
    
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.cancelBtn];
    
    self.cancelBtn.hidden = YES;
    
    
    
    //
    self.searchTextField = [[UITextField alloc]init];
    
    self.searchTextField.frame = CGRectMake(CGRectGetMaxX(imageV.frame)+ 3, (height - 30)/2, width - 20 - 20 - 10 -10- 5 , 30);
    
    //self.searchTextField.backgroundColor = [UIColor lightGrayColor];
    
    self.searchTextField.placeholder = @"输入城市名";
    
    self.searchTextField.borderStyle = UITextBorderStyleNone;
    
    self.searchTextField.delegate = self;
    
    [self addSubview:self.searchTextField];
    
    [self.searchTextField addTarget:self
                             action:@selector(textFieldDidChange:)
                   forControlEvents:UIControlEventEditingChanged];
    
    
 
}


static NSTimer *timer;

- (void)textFieldDidChange:(UITextField*)txf
{
    
    //NSLog(@"----change,%@----",txf.text);
    if (txf.text.length > 0)
    {
        self.cancelBtn.hidden = NO;
    }
    else
    {
        self.cancelBtn.hidden = YES;
    }
    
    //    if (没有数据)
    //    {
    //        if (txf.text.length > 0) {
    //            [self deleCustomActivity];
    //            [self addCustomActivityWithTitle:@"正在搜索" activity:YES];
    //        }else{
    //            [self deleCustomActivity];
    //        }
    //    }
    
    if ([timer isValid]) {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(searchpoi:) userInfo:txf repeats:NO];
    
}


- (void)searchpoi:(NSTimer *)sender
{
    
    UITextField *txf = [sender userInfo];
    
    [self searchKeywords:txf.text];
    
}



- (void)searchKeywords:(NSString *)str
{

    //处理字符串
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [self RemoveSpecialCharacter:str];
    
    if ([_delegate respondsToSelector:@selector(searchKeywords:)])
    {
        
        [_delegate searchKeywords:str];
    }
    
}





- (void)cancelBtnAction:(UIButton *)cancelBtn
{
    
    NSLog(@"-----删除-----");
    cancelBtn.hidden = YES;
    [self.searchTextField becomeFirstResponder];
    self.searchTextField.text = nil;
    [self searchKeywords:@""];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}



#pragma UIit
- (NSString*)RemoveSpecialCharacter: (NSString *)str
{
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"，,.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€'"]];
    if (urgentRange.location != NSNotFound)
    {
        return [self RemoveSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}














@end
