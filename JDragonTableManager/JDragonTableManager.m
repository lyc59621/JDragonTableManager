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
@property (nonatomic, assign) CGFloat  headerHeight;
@property (nonatomic, assign) CGFloat  footerHeight;
@property (nonatomic, assign) CGSize  itemSize;
@property (nonatomic, copy)   JDTabSelectCellBlock selectCellBlock;


#pragma mark-------------------TabDataSource----------------------------
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSString *reuseIdentifier;
@property(nonatomic,strong) NSArray  *reuseIdentArr;
@property(nonatomic,strong) NSObject  *currentObj;
@property(nonatomic,assign) BOOL  isSection;
@property(nonatomic,strong) NSArray *data;

@end
@implementation JDragonTableManager

#pragma mark-------------------TabDelegate-----------------------------
+ (instancetype)tabDelegateWithtableView:(UITableView *)tableView
                      andReuseIdentifier:(NSObject *)reuseobj
                            HeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(JDTabSelectCellBlock)selectBlock
{
    return  [[[self class] alloc]initTabDelegateWithtableView:tableView andReuseIdentifier:reuseobj headerHeight:hHeight footerHeight:fHeight selectBlock:selectBlock];
}

- (instancetype)initTabDelegateWithtableView:(UITableView *)tableView
                          andReuseIdentifier:(NSObject *)reuseobj
                                headerHeight:(CGFloat)hHeight
                                footerHeight:(CGFloat)fHeight
                                 selectBlock:(JDTabSelectCellBlock)selectBlock{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.headerHeight = hHeight;
        self.footerHeight = fHeight;
        self.selectCellBlock = selectBlock;
        self.tableView.delegate = self;
        if ([reuseobj isKindOfClass:[NSString class]]) {
            self.reuseIdentifier = (NSString*)reuseobj;
        }else
        if ([reuseobj isKindOfClass:[NSArray class]]) {
            self.reuseIdentArr = (NSArray*)reuseobj;
        }
    }
    return self;
}
#pragma mark-------------------UITableViewDelegate-----------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView heightForHeaderInSection:section];
        }
    }
    return !self.headerHeight?FLT_MIN:self.headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView heightForFooterInSection:section];
        }
    }
    return !self.footerHeight?FLT_MIN:self.footerHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    //如果是预估高度
    if (self.tableView.estimatedRowHeight!=0) {
        return  UITableViewAutomaticDimension;
    }
    //如果设置了rowHeight
    if (self.tableView.rowHeight>0) {
        return self.tableView.rowHeight;
    }
    //使用FD自动高计算
    NSString  *reuse = @"";
    if (_reuseIdentArr!=nil) {
        
        reuse= _reuseIdentArr[indexPath.section];
    }else
    {
        reuse= _reuseIdentifier;
    }
    __weak typeof(self) weakself = self;
    return [tableView fd_heightForCellWithIdentifier:reuse cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
       [weakself cellDataInfoWithCell:cell withIndexPath:indexPath];
    }];
//    return [tableView fd_heightForCellWithIdentifier:reuse cacheByKey:[NSString stringWithFormat:@"%@%ld%ld",reuse,indexPath.section,indexPath.row] configuration:^(id cell) {
//        [weakself cellDataInfoWithCell:cell withIndexPath:indexPath];
//    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectCellBlock(indexPath);
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
   if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView willDisplayHeaderView:view forSection:section];
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
           if ([self.currentObj respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
               [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView willDisplayFooterView:view forSection:section];
           }
       }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView didEndDisplayingHeaderView:view forSection:section];
        }
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
  if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView didEndDisplayingFooterView:view forSection:section];
        }
    }
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
            [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView didEndEditingRowAtIndexPath:indexPath];
        }
    }
}

#pragma mark-------------------TabDataSource----------------------------
+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
             tabCurrentObj:(UIViewController*)currentObj
                 isSection:(BOOL)isSection
        andReuseIdentifier:(NSString *)reuseIdentifier{
    return [[[self class] alloc] initWithSource:source tabType:tabType tableView:tableView isSection:isSection tabCurrentObj:currentObj andReuseIdentifier:reuseIdentifier];
}
+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
             tabCurrentObj:(NSObject*)currentObj
                 isSection:(BOOL)isSection
     andReuseIdentifierArr:(NSArray *)reuseIdentifierArr{
    
    return [[[self class] alloc]initWithSource:source tabType:tabType  tableView:tableView isSection:isSection tabCurrentObj:currentObj andReuseIdentifierArr:reuseIdentifierArr];
}
- (instancetype)initWithSource:(NSArray *)source
                       tabType:(JDTabHelpType)tabType
                     tableView:(UITableView *)tableView
                     isSection:(BOOL)isSection
                 tabCurrentObj:(NSObject*)currentObj
            andReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super init]) {
        _isSection = isSection;
        _tableView = tableView;
        _reuseIdentifier = reuseIdentifier;
        _data = @[];
        _currentObj = currentObj;
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
                tabCurrentObj:(NSObject*)currentObj
        andReuseIdentifierArr:(NSArray *)reuseIdentifierArr
{
    if (self = [super init]) {
        _isSection = isSection;
        _tableView = tableView;
        _reuseIdentArr = reuseIdentifierArr;
        _data = @[];
        _currentObj = currentObj;
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

-(void)setCellHeaderHeight:(CGFloat)hHeight
              footerHeight:(CGFloat)fHeight
               selectBlock:(JDTabSelectCellBlock)selectBlock
{
    
    self.headerHeight = hHeight;
    self.footerHeight = fHeight;
    self.tableView.delegate = self;
    self.selectCellBlock = selectBlock;
}

-(void)setReuseIdentifierArrayInSectionTypeWithArray:(NSArray*)array
{
    _reuseIdentArr = array;
}
-(void)setReuseIdentifierOneTypeWithReuseStr:(NSString*)identifier
{
    _reuseIdentifier = identifier;
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

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView viewForFooterInSection:section];
        }
    }
    return  [UIView new];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
            return   [( UIViewController<UITableViewDelegate> *)self.currentObj  tableView:tableView viewForHeaderInSection:section];
        }
    }
    return [UIView new];
}
-(void)cellDataInfoWithCell:(UITableViewCell*)cell withIndexPath:(NSIndexPath*)indexPath
{
    NSObject *data;
    //如果代理去实现自己给cell 设置data的方法
    if (self.delegate&&[self.delegate respondsToSelector:@selector(getCellDataInfoWithCell:withIndexPath:)]) {
        
       data =[self.delegate getCellDataInfoWithCell:cell withIndexPath:indexPath];
    }else//实现默认方法取出data
    {
       data = [self getCellDataInfoWithCell:cell withIndexPath:indexPath];
    }
    //    NSTimeInterval startLoadTime = [[NSDate date] timeIntervalSince1970];
      if ([cell conformsToProtocol:@protocol(JDTableManagerDelegate) ]) {
          if ([cell respondsToSelector:@selector(PrepareToWithAppear:WithCurentObj:WithIndexPath:)]) {
              [( UITableViewCell<JDTableManagerDelegate> *)cell  PrepareToWithAppear:data WithCurentObj:self.currentObj WithIndexPath:indexPath];
          }
      }
      //    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
      //    NSLog(@"cell %@ ,加载时间:%lf",indexPath,endTime - startLoadTime);
}
-(NSObject*)getCellDataInfoWithCell:(UITableViewCell*)cell withIndexPath:(NSIndexPath*)indexPath
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
    return data;
}
#pragma mark-------------------UITableViewDataSource----------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
          return  [( UIViewController<UITableViewDataSource> *)self.currentObj numberOfSectionsInTableView:tableView];
        }
    }
    NSInteger  count = 1;
    if (_isSection) {
        count = self.data.count;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
          return  [( UIViewController<UITableViewDataSource> *)self.currentObj  tableView:tableView numberOfRowsInSection:section];
        }
    }
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
    
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
            return  [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView cellForRowAtIndexPath:indexPath ];
        }
    }
    
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

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
            return  [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView titleForHeaderInSection:section ];
        }
    }
    return @"";
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
            return  [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView titleForFooterInSection:section ];
        }
    }
    return @"";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
            return  [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView canEditRowAtIndexPath:indexPath ];
        }
    }
    return false;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
            return  [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView canMoveRowAtIndexPath:indexPath ];
        }
    }
    return false;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
            return  [( NSObject<UITableViewDataSource> *)self.currentObj  sectionIndexTitlesForTableView:tableView ];
        }
    }
    NSMutableArray  *strArray = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i<self.data.count; i++) {
        [strArray addObject:@""];
    }
    return strArray;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
            return  [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
        }
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
            [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    if ([self.currentObj conformsToProtocol:@protocol(UITableViewDataSource) ]) {
        if ([self.currentObj respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
            [( NSObject<UITableViewDataSource> *)self.currentObj  tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
        }
    }
}









#pragma mark-------------------UIScrollViewDelegate----------------------------

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewDidScroll:scrollView];
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
            [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewWillBeginDragging:scrollView];
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
            [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        }
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
            [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewWillBeginDecelerating:scrollView];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewDidEndDecelerating:scrollView];
        }
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
   if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
            [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewDidEndScrollingAnimation:scrollView];
        }
    }
}
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
   if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
        if ([self.currentObj respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
           return [( NSObject<UIScrollViewDelegate> *)self.currentObj  viewForZoomingInScrollView:scrollView];
        }
    }
    return nil;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
   if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
      if ([self.currentObj respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
          [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewWillBeginZooming:scrollView withView:view];
        }
    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
   if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
       if ([self.currentObj respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
           [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewDidEndZooming:scrollView withView:view atScale:scale];
        }
    }
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
   if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
       if ([self.currentObj respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
         return [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewShouldScrollToTop:scrollView];
        }
    }
    return true;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
   if ([self.currentObj conformsToProtocol:@protocol(UIScrollViewDelegate) ]) {
       if ([self.currentObj respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
          [( NSObject<UIScrollViewDelegate> *)self.currentObj  scrollViewDidScrollToTop:scrollView];
        }
    }
}

@end


