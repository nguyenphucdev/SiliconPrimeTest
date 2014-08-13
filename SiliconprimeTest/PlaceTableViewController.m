//
//  PlaceTableViewController.m
//  SiliconprimeTest
//
//  Created by Apple on 7/31/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "PlaceTableViewCell.h"
#import "MapTableViewCell.h"
#import <MapKit/MapKit.h>
#import "Place.h"
#import "Utils.h"
#import "Setting.h"
#import "Constants.h"
#import "CustomAnnotation.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PlaceTableViewController (){
    GMSMapView *mapView_;
}

@end

@implementation PlaceTableViewController
@synthesize headerView,points,fetchedObjects;
PopoverListView *listView;
UIView *backgroundView;
UIImageView * imgCheck,*imgUnCheck;
UIView *disableViewOverlay;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.view.frame = CGRectMake(0, 10, self.tableView.frame.size.width, self.view.frame.size.height);

    // read json data

    NSString *jsonString = [[NSBundle mainBundle] pathForResource:@"Directions" ofType:@"geojson"];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:jsonString]
                                                         options:0
                                                           error:nil];

    points = [[[jsonDic objectForKey:@"coordinates"] objectAtIndex:0]  mutableCopy];
    
    // load data from db
   NSArray *sort= [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                  ascending:YES
                                                                           selector:@selector(localizedCaseInsensitiveCompare:)],nil];
    
    fetchedObjects=[[CoreDataManager sharedManager] fetchEntitiesWithClassName:@"Place" sortDescriptors:sort sectionNameKeyPath:nil predicate:nil];
    
    _filteredArray = [[NSMutableArray alloc] init];
    for (Place *place in [fetchedObjects fetchedObjects]) {
        [_filteredArray addObject:place];
    }
    
    UITapGestureRecognizer *tapImageDetail = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(resignFirstResponder)];
    tapImageDetail.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapImageDetail];
}
-(void)resignFirstResponderSearch{
    [self.searchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
    // Return the number of rows in the section.
    return [_filteredArray count];
}
-(void) CellDecor:(UITableViewCell *) cell
{
    

    [cell.contentView.layer setBorderColor:[UIColor colorWithRed:0.926 green:0.931 blue:0.931 alpha:1.000].CGColor];
    
    
    [cell.contentView.layer setBorderWidth:5.0f];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(22.0, 22.0)];
    
    // Create the shadow layer
    CAShapeLayer *shadowLayer = [CAShapeLayer layer];
    [shadowLayer setFrame:cell.bounds];
    [shadowLayer setMasksToBounds:NO];
    [shadowLayer setShadowPath:maskPath.CGPath];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = cell.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    cell.layer.mask = maskLayer;

    
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorColor = [UIColor clearColor];

    if (indexPath.section==0) {
        
        MapTableViewCell *mapTableViewCell =[[MapTableViewCell alloc] init];
    
        mapTableViewCell=( MapTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
        [mapTableViewCell.btnFillter addTarget:self
                                        action:@selector(Fillter:)
                              forControlEvents:UIControlEventTouchUpInside];
        
        [self CellDecor:mapTableViewCell];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                                longitude:148.60
                                                                     zoom:6];
        mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, mapTableViewCell.mapViewGoogle.frame.size.width, mapTableViewCell.mapViewGoogle.frame.size.height) camera:camera];
        mapView_.myLocationEnabled = YES;
        [mapTableViewCell.mapViewGoogle addSubview:mapView_] ;
        
        for ( int i=0; i<[self.points count]; i++)
        {
             CLLocationCoordinate2D coordinate       = {.latitude =  [[[self.points objectAtIndex:i] objectAtIndex:1] doubleValue], .longitude = [[[self.points objectAtIndex:i] objectAtIndex:0] doubleValue]};
            
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(coordinate.longitude,coordinate.latitude);
            GMSMarker *gmarker = [[GMSMarker alloc] init];
            gmarker.position = position;
            gmarker.icon = [UIImage imageNamed:@"ic_location"];
            gmarker.title= @"Sydney";
            gmarker.snippet = @"Australia";
            gmarker.map = mapView_;
            
            
        }
        

        return mapTableViewCell;
        
    }
    else
    {
       
   
        PlaceTableViewCell * placeTableViewCell =[[PlaceTableViewCell alloc] init];
        placeTableViewCell=(PlaceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MainCell"];
            Place *place=[_filteredArray objectAtIndex:indexPath.row];
            placeTableViewCell.lblPlaceName.text=place.name ;
            placeTableViewCell.lblAddress.text=place.address ;
            placeTableViewCell.lblDescription.text=place.desc ;
            [placeTableViewCell.mainImageView setImage:[UIImage imageNamed:place.image]];
            placeTableViewCell.lblPoint.text= [NSString stringWithFormat:@"%@",place.rating ] ;
            placeTableViewCell.place = place;
        
        for( int i=0;i<[place.rating floatValue];i++)
        {
            UIImageView *imageView;
            UIImage *starHalf=[UIImage imageNamed:@"ic_rating_05"];
            UIImage *starOne=[UIImage imageNamed:@"ic_rating_1"];
            CGRect starViewFrame = placeTableViewCell.starView.frame;
            

            if(i+ 0.5==[place.rating floatValue] )
            {

                imageView=[[UIImageView alloc] initWithFrame:CGRectMake(starViewFrame.origin.x +(i*12) ,starViewFrame.origin.y , 9, 9)];
                [imageView setImage:starHalf];

            }
            else
            {
                imageView=[[UIImageView alloc] initWithFrame:CGRectMake(starViewFrame.origin.x +i*12 ,starViewFrame.origin.y , 9, 9)];
                [imageView setImage:starOne];
            
            }
            
            
            [placeTableViewCell addSubview:imageView];
            
        
        }
        [self CellDecor:placeTableViewCell];
        return placeTableViewCell;
    }
    return nil;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     if(section == 0)
     {
         return headerView;
     }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
    {
        return 55;
    }
    return 0;
}
#pragma action

- (IBAction)Fillter:(id)sender {
    [self.searchBar resignFirstResponder];
    backgroundView =[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [backgroundView setBackgroundColor:[UIColor colorWithWhite:0.276 alpha:0.900]];
    [self.view.superview addSubview:backgroundView];
    listView = [[PopoverListView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    listView.titleName.text = @"FILTER BY";
    listView.datasource = self;
    listView.delegate = self;
    id lis=listView;
        [listView setDoneButtonWithTitle:@"Search" block:^{
            if ([lis indexPathForSelectedRow].row == 0) {
                [backgroundView setHidden:YES];
                
            }else{
            
                [backgroundView setHidden:YES];
                //saving setting to db coredata
                NSNumber *setting=[NSNumber numberWithInteger:[lis indexPathForSelectedRow].row];
                if (setting==nil) {
                    setting=[NSNumber numberWithInt:0];
                }
                NSString  *userID=[[NSUserDefaults standardUserDefaults] objectForKey:defaultUserID];
            
                NSDictionary *settingDic=[[NSDictionary alloc] initWithObjectsAndKeys:setting,@"idSetting",userID,@"idUser", nil];
                [[CoreDataManager sharedManager] createEntityWithClassName:@"Setting" attributesDictionary:settingDic];
                NSArray *sort= [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"idUser"
                                                                                       ascending:YES
                                                                                        selector:@selector(localizedCaseInsensitiveCompare:)],nil];
                fetchedObjects=[[CoreDataManager sharedManager] fetchEntitiesWithClassName:@"Setting" sortDescriptors:sort sectionNameKeyPath:nil predicate:nil];
                Setting* test =  [[fetchedObjects fetchedObjects] objectAtIndex:0];
    
                NSLog(@"Id User : %@ , Id Setting filter : %@",test.idUser,test.idSetting);
            }
            
        }];
    [listView show];
    
    
    
}

- (IBAction)AcBackHome:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)AcMenu:(id)sender {
    [Utils showMessageNotSupport];

}
#pragma Fillter list implement
#pragma mark -
- (NSInteger)popoverListView:(PopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)popoverListView:(PopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arrIcon = [[NSArray alloc] initWithObjects:@"ic_filter_location",@"ic_filter_rating",@"ic_filter_promotion",@"ic_filter_promotion",@"ic_filter_staffpick", nil];
    
     NSArray *arrFillterText = [[NSArray alloc] initWithObjects:@"LOCATION",@"RATING",@"PROMOTIONS NEAR BY",@"PROMOTIONS HIGHT RATING",@"STAFF PICKS", nil];
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:[arrIcon objectAtIndex: indexPath.row]];
    
    imgUnCheck=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,15,15)];
   
    imgUnCheck.image = [UIImage imageNamed:@"ic_select_uncheck"];
    cell.accessoryView = imgUnCheck;

    cell.textLabel.text = [arrFillterText objectAtIndex: indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
    return cell;
}


- (void)popoverListView:(PopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    imgUnCheck=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,15,15)];
    imgUnCheck.image = [UIImage imageNamed:@"ic_select_uncheck"];
    cell.accessoryView =imgUnCheck;
    
    
    NSLog(@"deselect:%d", indexPath.row);
}

- (void)popoverListView:(PopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    imgCheck=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,15,15)];
    imgCheck.image = [UIImage imageNamed:@"ic_select_checked"];
    cell.accessoryView =imgCheck;
    
    
    NSLog(@"select:%d", indexPath.row);
    
}


#pragma searchbar

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    /*[self filterContentForSearchText:searchBar.text scope:@"All"];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
     */
    NSArray *sort= [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                           ascending:YES
                                                                            selector:@selector(localizedCaseInsensitiveCompare:)],nil];
    // Search with name or Address or Description
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ OR address CONTAINS[cd] %@ OR desc CONTAINS[cd] %@",searchBar.text,searchBar.text, searchBar.text];
    fetchedObjects=[[CoreDataManager sharedManager] fetchEntitiesWithClassName:@"Place" sortDescriptors:sort sectionNameKeyPath:nil predicate:pred];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;

    [_filteredArray removeAllObjects];
    for (Place *place in [fetchedObjects fetchedObjects]) {
        [_filteredArray addObject:place];
    }
    [self.tableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *) ww
{
    return true;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	NSLog(@"Previous Search Results were removed.");
    [_filteredArray removeAllObjects];
	for (Place *role in [self.fetchedObjects fetchedObjects])
	{
		if ([scope isEqualToString:@"All"] || [role.name isEqualToString:scope])
		{
			NSComparisonResult result = [role.name compare:searchText
                                                   options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                     range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
			{
                NSLog(@"Adding role.name '%@' to searchResults as it begins with search text '%@'", role.name, searchText);
				[_filteredArray addObject:role];
            }
		}
	}
}

@end
