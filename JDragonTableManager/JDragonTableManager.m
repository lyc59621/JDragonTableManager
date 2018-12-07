//
//  JDragonTableManager.m
//  TestTableManager
//
//  Created by JDragon on 2016/12/15.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "JDragonTableManager.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface JDragonTableManager ()<UITableViewDataSource,UITableViewDelegate>

#pragma mark-------------------TabDelegate-----------------------------
@property (nonatomic, assign) CGFloat  rowHeight;
@property (nonatomic, assign) CGFloat  headerHeight;
@property (nonatomic, assign) CGFloat  footerHeight;
@property (nonatomic, assign) CGSize  itemSize;
@property (nonatomic, copy)   JDTabSelectCellBlock selectCellBlock;
@property (nonatomic, assign)   BOOL isAutoHeight;   //是否自动高


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
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView heightForHeaderInSection:section];
        }
    }
    return !self.headerHeight?0.0001:self.headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView heightForFooterInSection:section];
        }
    }
    return !self.footerHeight?0.0001:self.footerHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectCellBlock(indexPath);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    if (!self.isAutoHeight) {
        return  self.tableView.rowHeight;
    }
    NSString  *reuse = @"";
    if (_reuseIdentArr!=nil) {
        
        reuse= _reuseIdentArr[indexPath.section];
    }else
    {
        reuse= _reuseIdentifier;
    }
    return [tableView fd_heightForCellWithIdentifier:reuse cacheByKey:reuse configuration:^(id cell) {
        [self cellDataInfoWithCell:cell withIndexPath:indexPath];
    }];
    //    return [tableView fd_heightForCellWithIdentifier:reuse cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
    //
    //
    //    }];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView didEndEditingRowAtIndexPath:indexPath];
        }
    }
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

-(void)setCellAutoHeightAndeHeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(JDTabSelectCellBlock)selectBlock
{
    
    self.headerHeight = hHeight;
    self.footerHeight = fHeight;
    self.isAutoHeight = true;
    self.tableView.delegate = self;
    self.selectCellBlock = selectBlock;
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
    if (_reuseIdentArr!=nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentArr[indexPath.section] forIndexPath:indexPath];
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
    }
    [self cellDataInfoWithCell:cell withIndexPath:indexPath];
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView viewForFooterInSection:section];
        }
    }
    return  [UIView new];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentVC  tableView:tableView viewForHeaderInSection:section];
        }
    }
    return [UIView new];
}
-(void)cellDataInfoWithCell:(UITableViewCell*)cell withIndexPath:(NSIndexPath*)indexPath
{
    NSObject *data;
    switch (self.tabHelpType) {
        case NumberOfRowsInSectionNum:
            data = self.isSection?self.data[indexPath.section][indexPath.row]:self.data[indexPath.row];
            break;
        case NumberOfRowsInSectionCount:
            data = self.data[indexPath.row];
            break;
        case NumberOfRowsInSectionOne:
            data = self.isSection?self.data[indexPath.section]:self.data[indexPath.row];
            break;
        default:
            break;
    }
    //    NSTimeInterval startLoadTime = [[NSDate date] timeIntervalSince1970];
    if ([cell conformsToProtocol:@protocol(JDTableManagerDelegate) ]) {
        if ([cell respondsToSelector:@selector(PrepareToWithAppear:WithCurentVC:WithIndexPath:)]) {
            [( UITableViewCell<JDTableManagerDelegate> *)cell  PrepareToWithAppear:data WithCurentVC:self.currentVC WithIndexPath:indexPath];
        }
    }
    //    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    //    NSLog(@"cell %@ ,加载时间:%lf",indexPath,endTime - startLoadTime);
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
            return  [( UIViewController<UITableViewDataSource> *)self.currentVC  tableView:tableView canEditRowAtIndexPath:indexPath ];
        }
    }
    return false;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
           return  [( UIViewController<UITableViewDataSource> *)self.currentVC  tableView:tableView canMoveRowAtIndexPath:indexPath ];
        }
    }
    return false;
}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDataSource) ]) {
//        if ([self.currentVC respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
//        return     [( UIViewController<UITableViewDataSource> *)self.currentVC  tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
//        }
//    }
//    return 0;
//}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDataSource> *)self.currentVC  tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if ([self.currentVC conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentVC respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
            [( UIViewController<UITableViewDataSource> *)self.currentVC  tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.currentVC conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentVC respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [( UIViewController<UIScrollViewDelegate> *)self.currentVC  scrollViewDidScroll:scrollView];
        }
    }
}
-(void)setReuseArrayInSectionTypeWithArray:(NSArray*)array
{
    _reuseIdentArr = array;
}
-(void)updateReloadData:(NSArray*)datas
{
    self.data = datas;
    [_tableView reloadData];
}
-(void)updateData:(NSArray*)datas
{
    self.data = datas;
}

@end

