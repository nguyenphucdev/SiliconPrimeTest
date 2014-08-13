//
//  PlaceTableViewController.h
//  SiliconprimeTest
//
//  Created by VinhPhuc on 7/31/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreDataManager.h"
#import "PopoverListView.h"
#import <FacebookSDK/FacebookSDK.h>
@interface PlaceTableViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate,MKMapViewDelegate,PZPopoverListDatasource, PZPopoverListDelegate>
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) NSFetchedResultsController *fetchedObjects;


@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property(nonatomic,weak) IBOutlet UIView * headerView;
- (IBAction)AcBackHome:(id)sender;
- (IBAction)AcMenu:(id)sender;

@end
