//
//  JDragonTableManager.h
//  TestTableManager
//
//  Created by JDragon on 2016/12/15.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^JDTabSelectCellBlock)(NSIndexPath *indexPath);

@protocol JDTableManagerDelegate <NSObject>

- (void)PrepareToWithAppear:(NSObject *)data  WithCurentVC:(UIViewController*)curentVC  WithIndexPath:(NSIndexPath*)indexPath;

@end
typedef enum JDTabHelpType:NSUInteger
{
    NumberOfRowsInSectionNum=0,  // NumRows----Of Group Section
    NumberOfRowsInSectionCount,  // NumRows----of One Section
    NumberOfRowsInSectionOne,    // Oneows-----of Section
    Test,
    
}JDTabHelpType ;
@interface JDragonTableManager : NSObject

@property(nonatomic,assign) JDTabHelpType  tabHelpType;

#pragma mark----------------------------TableDelegate--------------------------------
+ (instancetype)tabDelegateWithtableView:(UITableView *)tableView
                            HeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(JDTabSelectCellBlock)selectBlock;

#pragma mark----------------------------TableDataSource--------------------------------
- (instancetype)initWithSource:(NSArray *)source
                       tabType:(JDTabHelpType)tabType
                     tableView:(UITableView *)tableView
                     isSection:(BOOL)isSection
                         tabVC:(UIViewController*)tabVC
            andReuseIdentifier:(NSString *)reuseIdentifier;

-(instancetype)initWithSource:(NSArray *)source
                      tabType:(JDTabHelpType)tabType
                    tableView:(UITableView *)tableView
                    isSection:(BOOL)isSection
                        tabVC:(UIViewController*)tabVC
        andReuseIdentifierArr:(NSArray *)reuseIdentifierArr;

+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
                     TabVC:(UIViewController*)TabVC
                 isSection:(BOOL)isSection
        andReuseIdentifier:(NSString *)reuseIdentifier;


+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
                     TabVC:(UIViewController*)TabVC
                 isSection:(BOOL)isSection
     andReuseIdentifierArr:(NSArray *)reuseIdentifierArr;

// 合并delegate和
-(void)setCellAutoHeightAndeHeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(JDTabSelectCellBlock)selectBlock;

-(void)setReuseArrayInSectionTypeWithArray:(NSArray*)array;



//ReloadData
-(void)updateReloadData:(NSArray*)datas;


-(void)updateData:(NSArray*)datas;

@end

