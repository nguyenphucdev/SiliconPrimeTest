//
//  PlaceTableViewCell.h
//  SiliconprimeTest
//
//  Created by Apple on 7/31/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface PlaceTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *lblPlaceName;
@property (nonatomic,weak) IBOutlet UILabel *lblAddress;
@property (nonatomic,weak) IBOutlet UILabel *lblPoint;
@property (nonatomic,weak) IBOutlet UIImageView *starView;
@property (nonatomic,weak) IBOutlet UIImageView *mainImageView;
@property (nonatomic,weak) IBOutlet UILabel *lblDescription;
@property (nonatomic,strong)Place *place;

- (IBAction)shareFacebook:(id)sender;

@end
