//
//  FirstTableViewCell.m
//  SiliconprimeTest
//
//  Created by VinhPhuc on 7/31/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "CustomAnnotation.h"
@implementation FirstTableViewCell
@synthesize mapView,btnFillter,annoImgName;

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
    // Initialization code

    self.mapView.delegate=self;
   

}
//-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//   
//        CustomAnnotation * myLocation=(CustomAnnotation *) annotation;
//        MKAnnotationView *annotationView=[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
//        if(annotation==nil)
//            annotationView=myLocation.annotationView;
//        else
//            annotationView.annotation=annotation;
//        return annotationView;
//    
//    
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
   
    static NSString *identifier = @"CustomAnnotation";
    MKAnnotationView * annotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:annoImgName];
        
        
     
    }else {
        annotationView.annotation = annotation;
    }
    return annotationView;
}


#pragma mark go to a location
- (void)gotoLocation:(CLLocationCoordinate2D) local
{
    // start off by default in San Francisco
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = local.latitude;
    newRegion.center.longitude =  local.longitude;
    newRegion.span.latitudeDelta = 0.3;
    newRegion.span.longitudeDelta = 0.3;
    
    [self.mapView setRegion:newRegion animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)AcFilter:(id)sender {
    NSLog(@"click");
 
}

- (IBAction)AcSelectSpec:(id)sender {
    [FMUtils showMessageNotSupport];
}
@end
