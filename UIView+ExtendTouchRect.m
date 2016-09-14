//
//  UIView+ExtendTouchRect.m
//  TestDemo
//
//  Created by sunwf on 16/9/8.
//  Copyright © 2016年 sunwf. All rights reserved.
//

#import "UIView+ExtendTouchRect.h"
#import <objc/runtime.h>

void swizzle(Class cls ,SEL orign ,SEL new)
{
    Method   orignMethod = class_getInstanceMethod(cls, orign);
    Method   newMethod = class_getInstanceMethod(cls, new);
    if (class_addMethod(cls, orign, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(cls, new, method_getImplementation(orignMethod), method_getTypeEncoding(orignMethod));
        
    }else
    {
        
        method_exchangeImplementations(orignMethod, newMethod);
    }
    
}


@implementation UIView (ExtendTouchRect)

+(void)load
{
    swizzle(self, @selector(pointInside:withEvent:), @selector(my_PointInside:withEvent:));
    
}

-(BOOL)my_PointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInsets, UIEdgeInsetsZero) || self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self my_PointInside:point withEvent:event]; // original implementation
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.touchExtendInsets);
    hitFrame.size.width = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);}


//add property
static  char  extendInsetsKey;
-(void)setTouchExtendInsets:(UIEdgeInsets)touchExtendInsets
{
    objc_setAssociatedObject(self, &extendInsetsKey, [NSValue valueWithUIEdgeInsets:touchExtendInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UIEdgeInsets)touchExtendInsets
{
   return  [objc_getAssociatedObject(self, &extendInsetsKey) UIEdgeInsetsValue];
}


@end
