//
//  MapTableViewCell.m
//  SiliconprimeTest
//
//  Created by Apple on 7/31/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "MapTableViewCell.h"
#import "CustomAnnotation.h"
@implementation MapTableViewCell
@synthesize btnFillter,annoImgName,mapViewGoogle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    
    }
    return self;
}

- (void)awakeFromNib
{
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)AcSelectSpec:(id)sender {
    [Utils showMessageNotSupport];
}
@end
