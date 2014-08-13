//
//  CustomAnnotation.h
//  MapCallouts
//
//  Created by Apple on 8/4/14.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject<MKAnnotation>

@property(nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property(copy,nonatomic) NSString *title;
@property(copy,nonatomic) NSString * imageName;
-(id) initWithTitle:(NSString *) newTitle Location:(CLLocationCoordinate2D) location;

@end
