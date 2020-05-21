//
//  ThreeViewController.m
//  TestTableManagerDemo
//
//  Created by 姜锦龙 on 2020/5/21.
//  Copyright © 2020 JDragon. All rights reserved.
//

#import "ThreeViewController.h"
#import "aTableViewCell.h"
#import "bTableViewCell.h"
#import "JDragonTableManager.h"
#import "UITableView+JDragonTableManager.h"

@interface ThreeViewController ()<JDTableManagerDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;

@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,strong) JDragonTableManager   *tabDelagate;

@property (nonatomic,strong) JDragonTableManager   *tabDataSource;
@property (nonatomic,strong) NSArray   *datas;


@end

@implementation ThreeViewController
-(NSArray*)datas{
    
    return @[@"你电话你都好多好多好多话好多好多话好多好多好多好多红红火火的活动都好好的",@"可是看看上课上课上课上课啦啦啦啦啦啦数据今生今世解决计算机技术u啊uu啊u啊u啊u啊u月夜夜夜夜夜夜额哦送送送",@"拍视频拍视频实拍爬山爬山爬山爬山爬山品牌爬山爬山爬山爬山时平时拍视频拍视频视频拍摄视频你的奶奶大男大女电脑电脑电脑你打打闹闹订单"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.aTableView.rowHeight = 0;
    [self.aTableView registerNib:[UINib nibWithNibName:@"bTableViewCell" bundle:nil] forCellReuseIdentifier:@"bTableViewCell"];
   
    [self oneType];
    
}

-(void)oneType
{
    self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:false reuseIdentifier:@"bTableViewCell"];

       [self.tabDataSource setCellHeaderHeight:40 footerHeight:40 selectBlock:^(NSIndexPath *indexPath) {
           NSLog(@"点击我了");
       }];
       [self.tabDataSource updateReloadData:@[@"11100000000000000023020320323瓦的娃的娃u的娃大大大大娃的娃都挖大的伟大的娃都挖的娃都挖的",@"0102010201021",@"你在哪里哇的哇的哇的哇的哇的哇的哇的啊我i对外点击挖机的挖掘低位佳绩   的挖掘的挖掘我的"]];
}
-(void)twoType
{
    self.tabDataSource = [self.aTableView JDTab_DelegateWithReuseIdentifier:@"bTableViewCell" headerHeight:20 footerHeight:20 selectBlock:^(NSIndexPath *indexPath) {
        NSLog(@"点击我了");
    }];
    self.tabDataSource.delegate = self;
    self.aTableView.dataSource = self;
    [self.aTableView reloadData];
    
}
-(NSObject*)getCellDataInfoWithCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    return self.datas[indexPath.row];
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
           case 0:
                [self oneType];
            break;
          case 1:
                [self twoType];
            break;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
  
    cell = [tableView dequeueReusableCellWithIdentifier:@"bTableViewCell" forIndexPath:indexPath];
    
    if ([cell conformsToProtocol:@protocol(JDTableManagerDelegate) ]) {
        if ([cell respondsToSelector:@selector(PrepareToWithAppear:WithCurentVC:WithIndexPath:)]) {
            [( UITableViewCell<JDTableManagerDelegate> *)cell  PrepareToWithAppear:self.datas[indexPath.row] WithCurentVC:self WithIndexPath:indexPath];
        }
    }
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
