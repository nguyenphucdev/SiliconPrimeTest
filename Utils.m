//
//  Utils.h
//  SiliconprimeTest
//
//  Created by Apple on 8/3/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//


#import "Utils.h"
#import "Constants.h"

@implementation Utils

+ (void)showMessageNotSupport{
    UIAlertView		*alertView = [[UIAlertView alloc]initWithTitle:nil
                                                        message:MSG_Not_Support
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}
@end
