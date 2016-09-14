//
//  UIGestureRecognizer+Block.h
//  TestDemo
//
//  Created by sunwf on 16/9/8.
//  Copyright © 2016年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^GestureBlock)(id gestureRecognizer);

@interface UIGestureRecognizer (Block)


+(id)addGestureActionWithBlock:(GestureBlock)block;
-(id)initWithGestureBlock:(GestureBlock)block;

@end
