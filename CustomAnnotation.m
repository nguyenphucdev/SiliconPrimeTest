//
//  CustomAnnotation.m
//  MapCallouts
//
//  Created by VinhPhuc on 8/4/14.
//
//

#import "CustomAnnotation.h"
@implementation CustomAnnotation
@synthesize title,coordinate;
-(id) initWithTitle:(NSString *) newTitle Location:(CLLocationCoordinate2D) location
{
    self=[super init];
    if(self)
    {
        title=newTitle;
        coordinate=location;
    }
    return  self;
}

//-(MKAnnotationView *) annotationView
//{
//    MKAnnotationView * annotationView=[[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"CustomAnnotation"];
//    annotationView.enabled=YES;
//    annotationView.canShowCallout=YES;
//    annotationView.image=[UIImage imageNamed:imageName];
//    annotationView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    return annotationView;
//}
@end
