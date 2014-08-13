//
//  FMUtils.h
//  SiliconprimeTest
//
//  Created by VinhPhuc on 8/3/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//


#import "FMUtils.h"
#import "Constants.h"

@implementation FMUtils

+ (void)showMessageNotSupport{
    UIAlertView		*alertView = [[UIAlertView alloc]initWithTitle:nil
                                                        message:MSG_Not_Support
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}
@end
