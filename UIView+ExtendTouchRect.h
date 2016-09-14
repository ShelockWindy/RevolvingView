//
//  UIView+ExtendTouchRect.h
//  TestDemo
//
//  Created by sunwf on 16/9/8.
//  Copyright © 2016年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ExtendTouchRect)

-(void)setTouchExtendInsets:(UIEdgeInsets)touchExtendInsets;
-(UIEdgeInsets)touchExtendInsets;

@end
