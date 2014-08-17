//
//  SwipeForOptionsCell.h
//  TableView_SwipeTableViewCell
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwipeForOptionsCell;

@protocol SwipeForOptionsCellDelegate <NSObject>

-(void)cellDidSelectDelete:(SwipeForOptionsCell *)cell;
-(void)cellDidSelectMore:(SwipeForOptionsCell *)cell;

@end

extern NSString *const SwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification;

@interface SwipeForOptionsCell : UITableViewCell

@property (nonatomic, weak) id<SwipeForOptionsCellDelegate> delegate;

@end
