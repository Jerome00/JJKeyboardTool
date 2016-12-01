//
//  JJKeyboardTool.m
//  自定义Toolbar
//
//  Created by JJ on 2016/12/1.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import "JJKeyboardTool.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGH [UIScreen mainScreen].bounds.size.height

@interface JJKeyboardTool ()

@property(nonatomic,strong)UITextField *currentField;

@end

@implementation JJKeyboardTool

-(instancetype)init{
    if (self=[super init]) {
       
        self.toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, HEIGH, WIDTH, 44)];
        
        UIBarButtonItem * previousItem = [[UIBarButtonItem alloc]initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(changePrevious)];
        UIBarButtonItem * nextItem = [[UIBarButtonItem alloc]initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(changeNext)];
       UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
        self.toolBar.items=@[previousItem,nextItem,spaceItem,doneItem];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        self.currentField=[[UITextField alloc]init];
    }
    return self;
}

//每次切换输入框都会调用
-(void)showToolBar:(UITextField *)field{
    self.currentField=field;
    NSInteger current=[self.fieldArray indexOfObject:self.currentField];
    
    if (current==0) {
        [self enableItemPrevious];
    }
    if (current==2) {
        [self enableItemNext];
    }
    if (current !=0 && current!=2) {
        [self ableItemNext];
        [self ableItemPrevious];
    }
}

//上一个
-(void)changePrevious{

    NSInteger current=[self.fieldArray indexOfObject:self.currentField];
    NSLog(@"当前的textfield %ld",current);

    if (current>0) {
        UITextField *filed=[self.fieldArray objectAtIndex:current-1];
        [filed becomeFirstResponder];
        [self ableItemNext];
        if (current-1 == 0) {
            [self enableItemPrevious];
            return;
        }else{
            [self ableItemPrevious];
            return;
        }
    }


}

//下一个
-(void)changeNext{

    NSInteger current=[self.fieldArray indexOfObject:self.currentField];
    if (current+1<self.fieldArray.count) {
        
        UITextField *filed=[self.fieldArray objectAtIndex:current+1];
        [filed becomeFirstResponder];
        [self ableItemPrevious];
        if (current+1 == self.fieldArray.count-1) {
            [self enableItemNext];
            return;
        }else{
            [self ableItemNext];
            return;
        }
    }
}

//完成
-(void)done{
    [self.currentField resignFirstResponder];
    self.toolBar.frame = CGRectMake(0, HEIGH, WIDTH, 44);
}

//键盘显示和隐藏调用
-(void)keyboardFrameChange:(NSNotification *)notification{
    NSDictionary *dict=[notification userInfo];
    NSValue *endValue = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endFrame = [endValue CGRectValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    NSNumber *isShowKeyboardValue = [dict objectForKey:UIKeyboardIsLocalUserInfoKey];
    BOOL isShowkeyboard = [isShowKeyboardValue boolValue];
    if (isShowkeyboard) {
        //键盘显示
        self.toolBar.frame = CGRectMake(0, endFrame.origin.y-44, WIDTH, 44);
    }else{
        //键盘隐藏
        self.toolBar.frame = CGRectMake(0, HEIGH, WIDTH, 44);
    }
    
    [UIView commitAnimations];
}


//上一个按钮不可点击
-(void)enableItemPrevious{
    UIBarButtonItem *item=self.toolBar.items[0];
    [item setTintColor:[UIColor grayColor]];
    item.enabled=NO;
}

//上一个按钮可以点击
-(void)ableItemPrevious{
    UIBarButtonItem *item=self.toolBar.items[0];
    [item setTintColor:[UIColor blueColor]];
    item.enabled=YES;
}

//下一个按钮不可点击
-(void)enableItemNext{
    UIBarButtonItem *item=self.toolBar.items[1];
    [item setTintColor:[UIColor grayColor]];
    item.enabled=NO;
}

//下一个按钮可以点击
-(void)ableItemNext{
    UIBarButtonItem *item=self.toolBar.items[1];
    [item setTintColor:[UIColor blueColor]];
    item.enabled=YES;
}


@end
