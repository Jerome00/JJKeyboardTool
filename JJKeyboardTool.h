//
//  JJKeyboardTool.h
//  Created by JJ on 2016/12/1.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JJKeyboardTool : NSObject

//用于光标切换的数组
@property(nonatomic,strong)NSArray *fieldArray;

@property(nonatomic,strong)UIToolbar *toolBar;

-(void)showToolBar:(UITextField *)field;

@end
