//
//  ViewController.m
//  KHSwipeCellExample
//
//  Created by Khan on 15-1-28.
//  Copyright (c) 2015年 Khan.lau. All rights reserved.
//

#import "ViewController.h"

#import "KHTableViewCell.h"
#import "KHActionButton.h"

#define kKHTableViewCellReuseIdentifier     @"KHTableViewCellIdentifier"

#define kFlagButtonColor        [UIColor colorWithRed:255.0/255.0 green:150.0/255.0 blue:0/255.0 alpha:1]
#define kMoreButtonColor        [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1]
#define kArchiveButtonColor     [UIColor colorWithRed:60.0/255.0 green:112.0/255.0 blue:168/255.0 alpha:1]
#define kUnreadButtonColor      [UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1]


@interface ViewController ()<KHSwipeCellDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;
@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"KHSwipeCell Example";
    
    [self resetData];
    
//    [self.tableView registerClass:[KHTableViewCell class] forCellReuseIdentifier:kKHTableViewCellReuseIdentifier];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(resetData)];
    self.navigationItem.rightBarButtonItem = resetButton;
}

- (void)resetData {
    self.tableData = [[NSMutableArray alloc] initWithCapacity:10];
    [self.tableData addObjectsFromArray:@[@"Swipe left all the way",
                                          @"Swipe right all they way",
                                          @"Swipe left - click More button",
                                          @"Swipe left - click Flag button",
                                          @"Swipe left - click Archive button",
                                          @"Swipe right - click Mark as unread button",
                                          @"Swipe right - click Delete button"]];
    
    [self.tableView reloadData];
}

- (NSArray *)leftButtons {
    __typeof(self) __weak weakSelf = self;
    KHActionButton *button1 = [KHActionButton actionButtonWithTitle:@"Delete" color:[UIColor redColor] handler:^(UIButton *actionButton, KHSwipeCell*cell) {
        [cell completePinToTopViewAnimation];
        [weakSelf leftMostButtonSwipeCompleted:cell];
        NSLog(@"Left Button: Delete Pressed");
    }];
    
    KHActionButton *button2 = [KHActionButton actionButtonWithTitle:@"Mark as unread" color:kUnreadButtonColor handler:^(UIButton *actionButton, KHSwipeCell*cell) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mark As Unread" message:@"Done!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        NSLog(@"Left Button: Mark as unread Pressed");
    }];
    
    return @[button1, button2];
}

- (NSArray *)rightButtons {
    __typeof(self) __weak weakSelf = self;
    KHActionButton *button1 = [KHActionButton actionButtonWithTitle:@"Archive" color:kArchiveButtonColor handler:^(UIButton *actionButton, KHSwipeCell*cell) {
        [cell completePinToTopViewAnimation];
        [weakSelf rightMostButtonSwipeCompleted:cell];
        NSLog(@"Right Button: Archive Pressed");
    }];
    
    KHActionButton *button2 = [KHActionButton actionButtonWithTitle:@"Flag" color:kFlagButtonColor handler:^(UIButton *actionButton, KHSwipeCell*cell) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Flag" message:@"Flag pressed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        NSLog(@"Right Button: Flag Pressed");
    }];
    KHActionButton *button3 = [KHActionButton actionButtonWithTitle:@"More" color:kMoreButtonColor handler:^(UIButton *actionButton, KHSwipeCell*cell) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"More Options" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Option 1" otherButtonTitles:@"Option 2",nil];
        [sheet showInView:weakSelf.view];
        NSLog(@"Right Button: More Pressed");
    }];
    
    return @[button1, button2, button3];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kKHTableViewCellReuseIdentifier];
    if (!cell) {
        cell = [[KHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kKHTableViewCellReuseIdentifier];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        cell.delegate = self;
    }
    
    [cell addActionButtons:[self leftButtons] withButtonWidth:kKHButtonWidth withButtonPosition:KHButtonLocationLeft];
    [cell addActionButtons:[self rightButtons] withButtonWidth:kKHButtonWidth withButtonPosition:KHButtonLocationRight];
//    cell.textLabel.text = self.tableData[indexPath.row];
//
    [cell configureCellWithTitle:self.tableData[indexPath.row]];
//    [cell setNeedsLayout];
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - JASwipeCellDelegate methods

- (void)swipingRightForCell:(KHSwipeCell *)cell {
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in indexPaths) {
        KHSwipeCell *visibleCell = (KHSwipeCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (visibleCell != cell) {
            [visibleCell resetContainerView];
        }
        
    }
}

- (void)swipingLeftForCell:(KHSwipeCell *)cell {
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in indexPaths) {
        KHSwipeCell *visibleCell = (KHSwipeCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (visibleCell != cell) {
            [visibleCell resetContainerView];
        }
        
    }
}

- (void)leftMostButtonSwipeCompleted:(KHSwipeCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableData removeObjectAtIndex:indexPath.row];

    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)rightMostButtonSwipeCompleted:(KHSwipeCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableData removeObjectAtIndex:indexPath.row];

    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in indexPaths) {
        KHSwipeCell *cell = (KHSwipeCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell resetContainerView];
    }
}

@end
