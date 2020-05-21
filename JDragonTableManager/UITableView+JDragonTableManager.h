//
//  UITableView+JDragonTableManager.h
//  TestTableManager
//
//  Created by JDragon on 2016/12/15.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDragonTableManager.h"

@interface UITableView (JDragonTableManager)

#pragma mark----------------------------TableDataSource--------------------------------

/**
 *  根据TabType获取DataSource(单个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                           withVC:(UIViewController*)VC
                        isSection:(BOOL)isSection
                  reuseIdentifier:(NSString *)reuseIdentifier;
/**
 *  根据TabType获取DataSource(多个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                           withVC:(UIViewController*)VC
                        isSection:(BOOL)isSection
               reuseIdentifierArr:(NSArray *)reuseIdentifierArr;
/**
 *  根据TabType获取DataSource(带数据源---单个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                          withVC:(UIViewController*)VC
                       isSection:(BOOL)isSection
                 reuseIdentifier:(NSString *)reuseIdentifier;
/**
 *  根据TabType获取DataSource(带数据源---多个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                          withVC:(UIViewController*)VC
                       isSection:(BOOL)isSection
              reuseIdentifierArr:(NSArray *)reuseIdentifierArr;


#pragma mark----------------------------TableDelegate--------------------------------
/**
 *  获取tabDelagate
 *
 *  @return TableViewDelagate
 */
- (id)JDTab_DelegateWithReuseIdentifier:(NSObject *)reuseobj
                           headerHeight:(CGFloat)hHeight
                           footerHeight:(CGFloat)fHeight
                            selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock;


/// 获取 tabDelagate
/// @param hHeight header
/// @param fHeight footer
/// @param selectBlock click
- (id)JDTab_DelegateWithHeaderHeight:(CGFloat)hHeight
                        footerHeight:(CGFloat)fHeight
                         selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock;




//- (id)JDTab_DelegateWithAutoHeight HeaderHeight:(CGFloat)hHeight
//                                   footerHeight:(CGFloat)fHeight
//                                    selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock;
@end

