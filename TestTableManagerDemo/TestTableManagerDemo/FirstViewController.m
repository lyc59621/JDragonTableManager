//
//  FirstViewController.m
//  TestTableManagerDemo
//
//  Created by JDragon on 2016/12/19.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "FirstViewController.h"
#import "aTableViewCell.h"
#import "bTableViewCell.h"
#import "JDragonTableManager.h"
#import "UITableView+JDragonTableManager.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *cellSegMent;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;

@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,strong) JDragonTableManager   *tabDelagate;
@property (nonatomic,strong) JDragonTableManager   *tabDataSource;

@property(nonatomic,assign) BOOL  isSingleCell;
@end
@implementation FirstViewController

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
    // 需要实现JDTableManagerDelegate 代理在cell里面
    self.tabDataSource = [self.aTableView JDTab_DataSourceWithSource:@[@"111",@"222"] withTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
    /*
    //第二种方式，可以不带原数据
    self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
    [self.tabDataSource updateReloadData:@[@"111",@"222"]];
     */
    
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

    
    if (!self.isSingleCell) {
    //单cell 情况
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
            [self.tabDataSource updateReloadData:@[@"111",@"222"]];
            break;
        case 1:
            self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionNum withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
            [self.tabDataSource updateReloadData:@[@[@"111",@"222"],@[@"333",@"444"]]];
            break;
        case 2:
            self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionOne withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
            [self.tabDataSource updateReloadData:@[@"111",@"222",@"333"]];
            break;
        default:
            break;
    }
    }else
    {
        //多cell 情况
        /*
           多种cell的情况下,ifierArr.count 必须要和ReloadData.count相等，不然会导致拿不到cell，出现崩溃
         */
        switch (sender.selectedSegmentIndex) {
            case 0:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifierArr:@[@"aTableViewCell",@"bTableViewCell"]];
                [self.tabDataSource updateReloadData:@[@"111",@"222"]];
                break;
            case 1:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionNum withVC:self isSection:true reuseIdentifierArr:@[@"aTableViewCell",@"bTableViewCell"]];
                [self.tabDataSource updateReloadData:@[@[@"333",@"444"],@[@"555",@"666"]]];
                break;
            case 2:
                self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionOne withVC:self isSection:true reuseIdentifierArr:@[@"aTableViewCell",@"bTableViewCell"]];
                [self.tabDataSource updateReloadData:@[@"777",@"888"]];
                break;
            default:
                break;
        }
    }
}
@end
