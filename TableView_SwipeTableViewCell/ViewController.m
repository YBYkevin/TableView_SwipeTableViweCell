//
//  ViewController.m
//  TableView_SwipeTableViewCell
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "ViewController.h"
#import "SwipeForOptionsCell.h"

 static NSString *swipeCellIndetifier = @"SwipeCell";

@interface ViewController ()<SwipeForOptionsCellDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"时间";
    [self.tableView registerClass:[SwipeForOptionsCell class] forCellReuseIdentifier:swipeCellIndetifier];
}


#pragma mark - TableVeiw Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SwipeForOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:swipeCellIndetifier forIndexPath:indexPath];
    NSDate *object = self.dataSource[indexPath.row];
    cell.textLabel.text = [object description];
    cell.delegate = self;
    
    return cell;
}


#pragma UIScrollViewDelegate Methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //当tableview滑动的时候 发送通知关闭已经展开的cell
    [[NSNotificationCenter defaultCenter] postNotificationName:SwipeForOptionsCellEnclosingTableViewDidBeginScrollingNotification object:scrollView];
    
}


#pragma mark - SwipeForOptionsCellDelegate Methods
-(void)cellDidSelectDelete:(SwipeForOptionsCell *)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)cellDidSelectMore:(SwipeForOptionsCell *)cell {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更多信息" delegate:nil cancelButtonTitle:@"忽略" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}


#pragma mark - Button Action

- (IBAction)addNewObject:(id)sender {

    [self.dataSource insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

#pragma mark - Property
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
