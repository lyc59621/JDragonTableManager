//
//  JDragonTableManager.h
//  TestTableManager
//
//  Created by JDragon on 2016/12/15.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
  README
  关于cell高度:
  通过设置TableView属性 estimatedRowHeight 或者 rowHeight 可自由切换自动高计算
  如果两者都关闭，或者都未设置的情况下，采用FD 自动高度计算缓存策略
 
  关于TableView 或者高度:
 */
 
typedef void(^JDTabSelectCellBlock)(NSIndexPath *indexPath);

@protocol JDTableManagerDelegate <NSObject>

@optional

/// vc 去实现
/// @param cell 当前cell
/// @param indexPath 当前indexPath
-(NSObject*)getCellDataInfoWithCell:(UITableViewCell*)cell withIndexPath:(NSIndexPath*)indexPath;


/// cell 去实现
/// @param data 数据
/// @param curentObj 当前VC 或者持有者
/// @param indexPath indexPath
- (void)PrepareToWithAppear:(NSObject *)data  WithCurentObj:(NSObject*)curentObj  WithIndexPath:(NSIndexPath*)indexPath;

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
@property(nonatomic,weak) id<JDTableManagerDelegate> delegate;

#pragma mark# TableDelegate

+ (instancetype)tabDelegateWithtableView:(UITableView *)tableView
                      andReuseIdentifier:(NSObject *)reuseobj
                            HeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(JDTabSelectCellBlock)selectBlock;

#pragma mark# TableDataSource

///实例方法 单个cell 类型展示
/// @param source 数据源
/// @param tabType Tab 展示类型
/// @param tableView tabview
/// @param currentObj tabVC 或者代理实现对象
/// @param isSection 是否分区
/// @param reuseIdentifier 唯一标识符
- (instancetype)initWithSource:(NSArray *)source
                       tabType:(JDTabHelpType)tabType
                     tableView:(UITableView *)tableView
                     isSection:(BOOL)isSection
                 tabCurrentObj:(NSObject*)currentObj
            andReuseIdentifier:(NSString *)reuseIdentifier;




///实例方法 多个cell 类型展示
/// @param source 数据源
/// @param tabType Tab 展示类型
/// @param tableView tabview
/// @param currentObj tabVC
/// @param isSection 是否分区
/// @param reuseIdentifierArr 唯一标识符数组
-(instancetype)initWithSource:(NSArray *)source
                      tabType:(JDTabHelpType)tabType
                    tableView:(UITableView *)tableView
                    isSection:(BOOL)isSection
                tabCurrentObj:(NSObject*)currentObj
        andReuseIdentifierArr:(NSArray *)reuseIdentifierArr;




///类方法 单个cell 类型展示
/// @param source 数据源
/// @param tabType Tab 展示类型
/// @param tableView tabview
/// @param currentObj tabVC
/// @param isSection 是否分区
/// @param reuseIdentifier 唯一标识符
+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
             tabCurrentObj:(NSObject*)currentObj
                 isSection:(BOOL)isSection
        andReuseIdentifier:(NSString *)reuseIdentifier;



///类方法 多个cell 类型展示
/// @param source 数据源
/// @param tabType Tab 展示类型
/// @param tableView tabview
/// @param currentObj tabVC
/// @param isSection 是否分区
/// @param reuseIdentifierArr 唯一标识符数组
+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
             tabCurrentObj:(NSObject*)currentObj
                 isSection:(BOOL)isSection
     andReuseIdentifierArr:(NSArray *)reuseIdentifierArr;


/// 合并delegate 手动设置Header&footer Height
/// @param hHeight section header 高
/// @param fHeight section footer 高
/// @param selectBlock 点击事件
-(void)setCellHeaderHeight:(CGFloat)hHeight
              footerHeight:(CGFloat)fHeight
               selectBlock:(JDTabSelectCellBlock)selectBlock;


/// 重新设置唯一标识符
/// @param array 标识符数组
-(void)setReuseIdentifierArrayInSectionTypeWithArray:(NSArray*)array;

/// 重新设置唯一标识符
/// @param identifier 唯一标识符
-(void)setReuseIdentifierOneTypeWithReuseStr:(NSString*)identifier;



/// 更新数据并刷新Tab
/// @param datas 数据源
-(void)updateReloadData:(NSArray*)datas;


/// 更新数据
/// @param datas 数据源
-(void)updateData:(NSArray*)datas;

@end

