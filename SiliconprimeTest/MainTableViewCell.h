//
//  MainTableViewCell.h
//  SiliconprimeTest
//
//  Created by VinhPhuc on 7/31/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *lblPlaceName;

@property (nonatomic,weak) IBOutlet UILabel *lblAddress;

@property (nonatomic,weak) IBOutlet UILabel *lblPoint;

@property (nonatomic,weak) IBOutlet UIImageView *starView;

@property (nonatomic,weak) IBOutlet UIImageView *mainImageView;

@property (nonatomic,weak) IBOutlet UILabel *lblDescription;

- (IBAction)acBook:(id)sender;

@end
