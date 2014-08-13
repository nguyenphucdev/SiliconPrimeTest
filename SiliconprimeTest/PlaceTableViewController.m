//
//  PlaceTableViewController.m
//  SiliconprimeTest
//
//  Created by VinhPhuc on 7/31/14.
//  Copyright (c) 2014 Happy. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "MainTableViewCell.h"
#import "FirstTableViewCell.h"
#import <MapKit/MapKit.h>
#import "Place.h"
#import "FMUtils.h"
#import "Setting.h"
#import "Constants.h"
#import "CustomAnnotation.h"

@interface PlaceTableViewController ()


@end

@implementation PlaceTableViewController
@synthesize headerView,points,fetchedObjects,searchBar;
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
    return [[fetchedObjects fetchedObjects] count];
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
        FirstTableViewCell *firstCell =[[FirstTableViewCell alloc] init];
    
        firstCell=( FirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
        [firstCell.btnFillter addTarget:self
                                        action:@selector(Fillter:)
                              forControlEvents:UIControlEventTouchUpInside];
        
        [self CellDecor:firstCell];

        CLLocationCoordinate2D coord       = {.latitude =  [[[self.points objectAtIndex:9] objectAtIndex:1] doubleValue], .longitude = [[[self.points objectAtIndex:9] objectAtIndex:0] doubleValue]}; // 9 for testing region
        

        MKCoordinateSpan span              = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
        MKCoordinateRegion region          = {coord, span};
        [ firstCell.mapView setRegion:region animated:TRUE];
        [ firstCell.mapView regionThatFits:region];

        for (NSUInteger i = 0; i < [self.points count]; i++)
        {
           
             CLLocationCoordinate2D coordinate       = {.latitude =  [[[self.points objectAtIndex:i] objectAtIndex:1] doubleValue], .longitude = [[[self.points objectAtIndex:i] objectAtIndex:0] doubleValue]};
            
            CustomAnnotation *anno=[[CustomAnnotation alloc] initWithTitle:[NSString stringWithFormat:@"Test %d",i] Location:coordinate];
            firstCell.annoImgName=@"ic_location_orange";
            [firstCell.mapView addAnnotation:anno];
            //[firstCell gotoLocation:coord];
        }
       
        

        return firstCell;
        
    }
    else
    {
       
   
        MainTableViewCell * mainCell =[[MainTableViewCell alloc] init];
        mainCell=( MainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MainCell"];
            Place *place=[[fetchedObjects fetchedObjects] objectAtIndex:indexPath.row];
            mainCell.lblPlaceName.text=place.name ;
            mainCell.lblAddress.text=place.address ;
            mainCell.lblDescription.text=place.desc ;
            [mainCell.mainImageView setImage:[UIImage imageNamed:place.image]];
            mainCell.lblPoint.text= [NSString stringWithFormat:@"%@",place.rating ] ;
        
        for( int i=0;i<[place.rating floatValue];i++)
        {
            UIImageView *imageView;
            UIImage *starHalf=[UIImage imageNamed:@"ic_rating_05"];
            UIImage *starOne=[UIImage imageNamed:@"ic_rating_1"];
            CGRect starViewFrame=mainCell.starView.frame;
            

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
            
            
            [mainCell addSubview:imageView];
            
        
        }
        [self CellDecor:mainCell];
        return mainCell;
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
        return 60;
    }
    return 0;
}
#pragma action

- (IBAction)Fillter:(id)sender {

    backgroundView =[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [backgroundView setBackgroundColor:[UIColor colorWithWhite:0.276 alpha:0.900]];
    [self.view.superview addSubview:backgroundView];
    listView = [[PopoverListView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    listView.titleName.text = @"FILTER BY";
    listView.datasource = self;
    listView.delegate = self;
    id lis=listView;
        [listView setDoneButtonWithTitle:@"Search" block:^{
            NSLog(@"Search id %d", [lis indexPathForSelectedRow].row);
            [backgroundView setHidden:YES];
            
            //saving setting to db coredata
            NSNumber *setting=[NSNumber numberWithInteger:[lis indexPathForSelectedRow].row];
            if (setting==nil) {
                setting=[NSNumber numberWithInt:0];
            }
            NSString  *userID=[[NSUserDefaults standardUserDefaults] objectForKey:defaultUserID];
            if(userID==nil)
            {
            userID=@"UnKnow";
            }
            NSDictionary *settingDic=[[NSDictionary alloc] initWithObjectsAndKeys:setting,@"idSetting",userID,@"idUser", nil];
            [[CoreDataManager sharedManager] createEntityWithClassName:@"Setting" attributesDictionary:settingDic];
            
            
            /**
             test data
             */
            //            NSArray *sort= [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"idUser"
            //                                                                                   ascending:YES
            //                                                                                    selector:@selector(localizedCaseInsensitiveCompare:)],nil];
            //            fetchedObjects=[[CoreDataManager sharedManager] fetchEntitiesWithClassName:@"Setting" sortDescriptors:sort sectionNameKeyPath:nil predicate:nil];
            //          Setting* e =  [[fetchedObjects fetchedObjects] objectAtIndex:0];
            
        }];
    [listView show];
    
    
    
}
- (IBAction)AcBackHome:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)AcMenu:(id)sender {
    [FMUtils showMessageNotSupport];

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


#pragma SEARCH

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;

    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
   
    [UIView commitAnimations];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
   
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSArray *sort= [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                           ascending:YES
                                                                            selector:@selector(localizedCaseInsensitiveCompare:)],nil];
    // Search with name or Address or Description
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ANY %@ IN name || ANY %@ IN address OR ANY %@ IN desc",searchBar.text,searchBar.text, searchBar.text];

    fetchedObjects=[[CoreDataManager sharedManager] fetchEntitiesWithClassName:@"Place" sortDescriptors:sort sectionNameKeyPath:nil predicate:pred];
	
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;

    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active{
    self.tableView.allowsSelection = !active;
    self.tableView.scrollEnabled = !active;
    if (!active) {
        [disableViewOverlay removeFromSuperview];
        [searchBar resignFirstResponder];
    } else {
        disableViewOverlay.alpha = 0;
        [self.view addSubview:disableViewOverlay];
		
        [UIView beginAnimations:@"FadeIn" context:nil];
        [UIView setAnimationDuration:0.5];
        disableViewOverlay.alpha = 0.6;
        [UIView commitAnimations];
		
        // probably not needed if you have a details view since you
        // will go there on selection
        NSIndexPath *selected = [self.tableView
                                 indexPathForSelectedRow];
        if (selected) {
            [self.tableView deselectRowAtIndexPath:selected
                                             animated:NO];
        }
    }
    [searchBar setShowsCancelButton:active animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [searchBar resignFirstResponder];
    
}

@end
