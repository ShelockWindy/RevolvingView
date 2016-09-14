//
//  UIGestureRecognizer+Block.m
//  TestDemo
//
//  Created by sunwf on 16/9/8.
//  Copyright © 2016年 sunwf. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>

static const int targetKey ;


@implementation UIGestureRecognizer (Block)

+(id)addGestureActionWithBlock:(GestureBlock)block
{
    return  [[self alloc]initWithGestureBlock:block];
}


-(id)initWithGestureBlock:(GestureBlock)block
{
    self  = [self init];
    [self  addActionBlock:block];
    [self addTarget:self action:@selector(invokeAction:)];
    
    return self;
}


-(void)addActionBlock:(GestureBlock)block
{
    if (block) {
        objc_setAssociatedObject(self, &targetKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

-(void)invokeAction:(id)sender
{
    GestureBlock block = objc_getAssociatedObject(self, &targetKey);

    if (block) {
        block(sender);
    }
}



@end
