//
//  PZPopoverListView.h
//  SiliconprimeTest
//
//  Created by Apple on 8/3/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PZPopoverListViewButtonBlock)();

@class PopoverListView;
@protocol PZPopoverListDatasource <NSObject>

- (NSInteger)popoverListView:(PopoverListView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)popoverListView:(PopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol PZPopoverListDelegate <NSObject>
- (void)popoverListView:(PopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)popoverListView:(PopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
@end

@interface PopoverListView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <PZPopoverListDelegate>delegate;
@property (nonatomic, retain) id <PZPopoverListDatasource>datasource;

@property (nonatomic, retain) UILabel *titleName;

- (void)show;

- (void)dismiss;

- (id)dequeueReusablePopoverCellWithIdentifier:(NSString *)identifier;

- (UITableViewCell *)popoverCellForRowAtIndexPath:(NSIndexPath *)indexPath;            // returns nil if cell is not visible or index path is out of

- (void)setDoneButtonWithTitle:(NSString *)aTitle block:(PZPopoverListViewButtonBlock)block;

- (void)setCancelButtonTitle:(NSString *)aTitle block:(PZPopoverListViewButtonBlock)block;

- (NSIndexPath *)indexPathForSelectedRow;
@end

