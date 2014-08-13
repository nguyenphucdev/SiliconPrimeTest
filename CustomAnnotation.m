//
//  CustomAnnotation.m
//  MapCallouts
//
//  Created by Apple on 8/4/14.
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
@end
