//
//  JDragonTableManager.m
//  TestTableManager
//
//  Created by JDragon on 2016/12/15.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "JDragonTableManager.h"

@interface JDragonTableManager ()<UITableViewDataSource,UITableViewDelegate>

#pragma mark-------------------TabDelegate-----------------------------
@property (nonatomic, assign) CGFloat  rowHeight;
@property (nonatomic, assign) CGFloat  headerHeight;
@property (nonatomic, assign) CGFloat  footerHeight;
@property (nonatomic, assign) CGSize  itemSize;
@property (nonatomic, copy)   JDTabSelectCellBlock selectCellBlock;


#pragma mark-------------------TabDataSource----------------------------
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSString *reuseIdentifier;
@property(nonatomic,strong) NSArray  *reuseIdentArr;
@property(nonatomic,strong) UIViewController  *currentVC;
@property(nonatomic,assign) BOOL  isSection;
@property(nonatomic,strong) NSArray *data;

@end
@implementation JDragonTableManager

#pragma mark---------------------------------TabDelegate-----------------------------------
+ (instancetype)tabDelegateWithtableView:(UITableView *)tableView
                            HeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(JDTabSelectCellBlock)selectBlock
{
    return  [[[self class] alloc]initTabDelegateWithtableView:tableView RowHeight:0 headerHeight:hHeight footerHeight:fHeight selectBlock:selectBlock];
}

- (instancetype)initTabDelegateWithtableView:(UITableView *)tableView
                                   RowHeight:(CGFloat)rowHeight
                                headerHeight:(CGFloat)hHeight
                                footerHeight:(CGFloat)fHeight
                                 selectBlock:(JDTabSelectCellBlock)selectBlock{
    self = [super init];
    if (self) {
        self.rowHeight = rowHeight;
        self.headerHeight = hHeight;
        self.footerHeight = fHeight;
        self.tableView = tableView;
        self.selectCellBlock = selectBlock;
        self.tableView.delegate = self;
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !self.headerHeight?0.0001:self.headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return !self.footerHeight?0.0001:self.footerHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectCellBlock(indexPath);
}
#pragma mark----------------------------------TabDataSource-------------------------------
+ (instancetype)dataSource:(NSArray *)source tabType:(JDTabHelpType)tabType tableView:(UITableView *)tableView TabVC:(UIViewController*)TabVC isSection:(BOOL)isSection andReuseIdentifier:(NSString *)reuseIdentifier{
    return [[[self class] alloc] initWithSource:source tabType:tabType tableView:tableView isSection:isSection tabVC:TabVC andReuseIdentifier:reuseIdentifier];
}
+ (instancetype)dataSource:(NSArray *)source tabType:(JDTabHelpType)tabType tableView:(UITableView *)tableView  TabVC:(UIViewController*)TabVC isSection:(BOOL)isSection andReuseIdentifierArr:(NSArray *)reuseIdentifierArr{
    return [[[self class] alloc]initWithSource:source tabType:tabType  tableView:tableView isSection:isSection tabVC:TabVC andReuseIdentifierArr:reuseIdentifierArr];
}
- (instancetype)initWithSource:(NSArray *)source
                       tabType:(JDTabHelpType)tabType
                     tableView:(UITableView *)tableView
                     isSection:(BOOL)isSection
                         tabVC:(UIViewController*)tabVC
            andReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super init]) {
        _isSection = isSection;
        _tableView = tableView;
        _reuseIdentifier = reuseIdentifier;
        _data = @[];
        _currentVC = tabVC;
        _tabHelpType = tabType;
        
        
        //        RAC(self, data) = [[source ignore:nil] doNext:^(NSArray *data) {
        //            dispatch_async(dispatch_get_main_queue(), ^{
        ////                [_tableView reloadData];
        //            });
        //        }];
        self.data = source;
        _tableView.dataSource = self;
    }
    return self;
}
-(instancetype)initWithSource:(NSArray *)source
                      tabType:(JDTabHelpType)tabType
                    tableView:(UITableView *)tableView
                    isSection:(BOOL)isSection
                        tabVC:(UIViewController*)tabVC
        andReuseIdentifierArr:(NSArray *)reuseIdentifierArr
{
    if (self = [super init]) {
        _isSection = isSection;
        _tableView = tableView;
        _reuseIdentArr = reuseIdentifierArr;
        _data = @[];
        _currentVC = tabVC;
        _tabHelpType = tabType;
        
        //        RAC(self, data) = [[source ignore:nil] doNext:^(NSArray *data) {
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //
        //                [_tableView reloadData];
        //            });
        //        }];
        self.data = source;
        _tableView.dataSource = self;
    }
    return self;
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger  count = 1;
    if (_isSection) {
        count = self.data.count;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger  count = self.data.count;
    if (_isSection) {
        switch (self.tabHelpType) {
            case Test:
            case NumberOfRowsInSectionCount:
                count = self.data.count;
                break;
            case NumberOfRowsInSectionOne:
                count=1;
                break;
            case NumberOfRowsInSectionNum:
                count = ((NSArray*)self.data[section]).count;
                break;
            default:
                break;
        }
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSObject *data;
    //    NSTimeInterval startLoadTime = [[NSDate date] timeIntervalSince1970];
    
    switch (self.tabHelpType) {
        case NumberOfRowsInSectionNum:
            if (_reuseIdentArr!=nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentArr[indexPath.section] forIndexPath:indexPath];
            }else
            {
                cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
            }
            data = self.data[indexPath.section][indexPath.row];
            break;
        case NumberOfRowsInSectionCount:
            cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
            data = self.data[indexPath.row];
            break;
        case NumberOfRowsInSectionOne:
            if (_reuseIdentArr!=nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentArr[indexPath.section] forIndexPath:indexPath];
            }else
            {
                cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
            }
            if(_isSection){
                data = self.data[indexPath.section];
            }else{
                data = self.data[indexPath.row];
            }
            break;
        default:
            break;
    }
    if ([cell conformsToProtocol:@protocol(JDTableManagerDelegate) ]) {
        
        [( UITableViewCell<JDTableManagerDelegate> *)cell  PrepareToWithAppear:data WithCurentVC:self.currentVC WithIndexPath:indexPath];
    }
    //    else if ([data isKindOfClass:[NSString class]]) {
    //
    //        cell.textLabel.text = (NSString *)data;
    //    }
    //
    //    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    //    NSLog(@"cell %@ ,加载时间:%lf",indexPath,endTime - startLoadTime);
    return cell;
}
-(void)updateReloadData:(NSArray*)datas
{
    self.data = datas;
    [_tableView reloadData];
}

@end
