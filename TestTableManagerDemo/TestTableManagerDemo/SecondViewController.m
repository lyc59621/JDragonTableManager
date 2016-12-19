//
//  SecondViewController.m
//  TestTableManagerDemo
//
//  Created by JDragon on 2016/12/19.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "SecondViewController.h"
#import "aTableViewCell.h"
#import "bTableViewCell.h"
#import "JDragonTableManager.h"
#import "UITableView+JDragonTableManager.h"


@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *cellSegMent;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,strong) JDragonTableManager   *tabDelagate;
@property (nonatomic,strong) JDragonTableManager   *tabDataSource;
@property(nonatomic,assign) BOOL  isSingleCell;

@end
@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUIConfig];
}
-(void)setUIConfig
{
    self.aTableView.estimatedRowHeight = 50;
    [self.aTableView registerClass:[aTableViewCell class] forCellReuseIdentifier:@"aTableViewCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"bTableViewCell" bundle:nil] forCellReuseIdentifier:@"bTableViewCell"];
    self.tabDelagate = [self.aTableView JDTab_DelegateWithHeaderHeight:10 footerHeight:10 selectBlock:^(NSIndexPath *indexPath) {
        NSLog(@"选中");
    }];
    self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:false reuseIdentifier:@"aTableViewCell"];
    [self.tabDataSource updateReloadData:@[@"111",@"222"]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cellSegmentAction:(UISegmentedControl *)sender {
    
    self.isSingleCell = sender.selectedSegmentIndex;
    [self segmentAction:self.typeSegment];
}
- (IBAction)segmentAction:(UISegmentedControl *)sender {
    
    
    //在不分区的情况下，多种cell的设定是无效的，因为cell的拿取和section有关联，现在只能做到这一步，等以后更新。
    if (!self.isSingleCell) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:false reuseIdentifier:@"aTableViewCell"];
                [self.tabDataSource updateReloadData:@[@"111",@"222"]];
                break;
            case 1:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionNum withVC:self isSection:false reuseIdentifier:@"aTableViewCell"];
                [self.tabDataSource updateReloadData:@[@[@"111",@"222"],@[@"333",@"444"]]];
                break;
            case 2:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionOne withVC:self isSection:false reuseIdentifier:@"aTableViewCell"];
                [self.tabDataSource updateReloadData:@[@"111",@"222",@"333"]];
                break;
            default:
                break;
        }
    }else
    {
        //多种cell的设定。只能拿到第一个cell。
        switch (sender.selectedSegmentIndex) {
            case 0:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:false reuseIdentifierArr:@[@"aTableViewCell",@"bTableViewCell"]];
                [self.tabDataSource updateReloadData:@[@"111",@"222"]];
                break;
            case 1:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionNum withVC:self isSection:false reuseIdentifierArr:@[@"aTableViewCell",@"bTableViewCell"]];
                [self.tabDataSource updateReloadData:@[@[@"111",@"222"],@[@"333",@"444"]]];
                break;
            case 2:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionOne withVC:self isSection:false reuseIdentifierArr:@[@"aTableViewCell",@"bTableViewCell"]];
                [self.tabDataSource updateReloadData:@[@"111",@"222"]];
                break;
            default:
                break;
        }
        
    }
    
}

@end
