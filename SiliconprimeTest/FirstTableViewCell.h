//
//  FirstTableViewCell.h
//  SiliconprimeTest
//
//  Created by VinhPhuc on 7/31/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FMUtils.h"

@interface FirstTableViewCell : UITableViewCell<MKMapViewDelegate>

@property (nonatomic, strong) NSString * annoImgName;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UIButton *btnFillter;
- (IBAction)AcFilter:(id)sender;
- (IBAction)AcSelectSpec:(id)sender;
- (void)gotoLocation:(CLLocationCoordinate2D) local;
-(MKAnnotationView*)mapView:(MKMapView *)_mapView viewForAnnotation:(id<MKAnnotation>)annotation;


@end
