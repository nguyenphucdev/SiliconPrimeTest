//
//  Place.h
//  SiliconprimeTest
//
//  Created by VinhPhuc on 8/3/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * desc;

@end
