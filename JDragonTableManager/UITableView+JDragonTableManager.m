
//
//  UITableView+JDragonTableManager.m
//  TestTableManager
//
//  Created by JDragon on 2016/12/15.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "UITableView+JDragonTableManager.h"

@implementation UITableView (JDragonTableManager)

- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                   tabCurrentObj:(UIViewController*)VC
                       isSection:(BOOL)isSection
                 reuseIdentifier:(NSString *)reuseIdentifier
{
    return [JDragonTableManager
            dataSource:source tabType:tabType tableView:self tabCurrentObj:VC isSection:isSection andReuseIdentifier:reuseIdentifier];
}
- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                   tabCurrentObj:(UIViewController*)currentObj
                       isSection:(BOOL)isSection
              reuseIdentifierArr:(NSArray *)reuseIdentifierArr
{
    return [JDragonTableManager dataSource:source tabType:tabType tableView:self tabCurrentObj:currentObj isSection:isSection andReuseIdentifierArr:reuseIdentifierArr];
}

- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                    tabCurrentObj:(UIViewController*)currentObj
                        isSection:(BOOL)isSection
                  reuseIdentifier:(NSString *)reuseIdentifier
{
    return [JDragonTableManager
            dataSource:nil tabType:tabType tableView:self tabCurrentObj:currentObj isSection:isSection andReuseIdentifier:reuseIdentifier];
    
}
- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                    tabCurrentObj:(UIViewController*)currentObj
                        isSection:(BOOL)isSection
               reuseIdentifierArr:(NSArray *)reuseIdentifierArr
{
    
    return [JDragonTableManager dataSource:nil tabType:tabType tableView:self tabCurrentObj:currentObj isSection:isSection andReuseIdentifierArr:reuseIdentifierArr];
}

- (id)JDTab_DelegateWithReuseIdentifier:(NSObject *)reuseobj
                           headerHeight:(CGFloat)hHeight
                           footerHeight:(CGFloat)fHeight
                            selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock

{
    return [JDragonTableManager tabDelegateWithtableView:self andReuseIdentifier:reuseobj HeaderHeight:hHeight footerHeight:fHeight selectBlock:selectBlock];
}
- (id)JDTab_DelegateWithHeaderHeight:(CGFloat)hHeight
                        footerHeight:(CGFloat)fHeight
                         selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock
{
   return [JDragonTableManager tabDelegateWithtableView:self andReuseIdentifier:nil HeaderHeight:hHeight footerHeight:fHeight selectBlock:selectBlock];
}
@end
