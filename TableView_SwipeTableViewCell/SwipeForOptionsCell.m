//
//  SwipeForOptionsCell.m
//  TableView_SwipeTableViewCell
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "SwipeForOptionsCell.h"

NSString *const SwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification = @"SwipeForOptionsCellEnclosingTableViewDidScrollNotification";

#define THRESHOLD_WIDTH 180

@interface SwipeForOptionsCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *scrollViewContentView;
@property (nonatomic, strong) UILabel *scrollViewLabel;

@property (nonatomic, strong) UIView *scrollViewButtonView;




@end

@implementation SwipeForOptionsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
    }
    return self;
}


-(void)setup {
    
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollViewButtonView];
    [self.scrollView addSubview:self.scrollViewContentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enclosingTableViewDidScroll) name:SwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification  object:nil];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + THRESHOLD_WIDTH, CGRectGetHeight(self.bounds));
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)scrollViewButtonView
{
    if (!_scrollViewButtonView) {
        
          _scrollViewButtonView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - THRESHOLD_WIDTH, 0, THRESHOLD_WIDTH, CGRectGetHeight(self.bounds))];
        
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        moreButton.backgroundColor = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0f];
        moreButton.frame = CGRectMake(0, 0, THRESHOLD_WIDTH / 2.0f, CGRectGetHeight(self.bounds));
        [moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [moreButton addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollViewButtonView addSubview:moreButton];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0f];
        deleteButton.frame = CGRectMake(THRESHOLD_WIDTH / 2.0f, 0, THRESHOLD_WIDTH / 2.0f, CGRectGetHeight(self.bounds));
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollViewButtonView addSubview:deleteButton];
    }
    return _scrollViewButtonView;
    
}

- (UIView *)scrollViewContentView
{
    if (!_scrollViewContentView) {
        _scrollViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _scrollViewContentView.backgroundColor = [UIColor whiteColor];
        [_scrollViewContentView addSubview:self.scrollViewLabel];
    }
    return _scrollViewContentView;
}

- (UILabel *)scrollViewLabel
{
    if (!_scrollViewLabel) {
        _scrollViewLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.scrollViewContentView.bounds, 10, 0)];
    }
    return _scrollViewLabel;
}

#pragma mark - Notification
-(void)enclosingTableViewDidScroll {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}


#pragma mark - Override SuperClass
-(UILabel *)textLabel {
    return self.scrollViewLabel;
}

#pragma mark - Private Methods

-(void)clickDeleteButton:(id)sender {
    [self.delegate cellDidSelectDelete:self];
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

-(void)clickMoreButton:(id)sender {
    [self.delegate cellDidSelectMore:self];
}

#pragma mark - UIScrollViewDelegate Methods


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (scrollView.contentOffset.x > THRESHOLD_WIDTH ) {
        targetContentOffset->x = THRESHOLD_WIDTH;
    }
    else {
        *targetContentOffset = CGPointZero;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [scrollView setContentOffset:CGPointZero animated:YES];
        });
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < 0) {
        scrollView.contentOffset = CGPointZero;
    }
    self.scrollViewButtonView.frame = CGRectMake(scrollView.contentOffset.x + (CGRectGetWidth(self.bounds) - THRESHOLD_WIDTH), 0.0f, THRESHOLD_WIDTH, CGRectGetHeight(self.bounds));
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
