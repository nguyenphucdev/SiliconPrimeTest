//
//  MapTableViewCell.h
//  SiliconprimeTest
//
//  Created by Apple on 7/31/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Utils.h"

@interface MapTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString * annoImgName;

@property(nonatomic,weak) IBOutlet UIView *mapViewGoogle;

@property (strong, nonatomic) IBOutlet UIButton *btnFillter;
- (IBAction)AcSelectSpec:(id)sender;

@end
