//
//  MBProgressHUD+CQ.m
//  sweibo
//
//  Created by y on 15/11/19.
//  Copyright © 2015年 y. All rights reserved.
//

#import "MBProgressHUD+CQ.h"
#import "MBProgressHUD.h"
@implementation MBProgressHUD (CQ)

+ (void)showLoading:(UIView *)v {
    MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:v animated:true];
    mb.labelText = @"加载中...";
    mb.dimBackground = YES;
    [mb hide:YES afterDelay:10.0];
    [mb removeFromSuperViewOnHide];
}

+ (void)hide:(UIView *)v1 {
    for (UIView *v in v1.subviews) {
        //NSLog(@"%@",v);
        if ([v isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *mb = (MBProgressHUD *)v;
            [mb hide:true];
        }
    }
}

@end
