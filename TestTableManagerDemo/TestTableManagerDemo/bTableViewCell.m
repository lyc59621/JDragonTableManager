//
//  bTableViewCell.m
//  TestTableManagerDemo
//
//  Created by JDragon on 2016/12/19.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "bTableViewCell.h"

#import "JDragonTableManager.h"

@interface bTableViewCell ()<JDTableManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *aLabel;

@end

@implementation bTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)PrepareToWithAppear:(NSObject *)data WithCurentVC:(UIViewController *)curentVC WithIndexPath:(NSIndexPath *)indexPath
{
    self.aLabel.text = [data isKindOfClass:[NSString class]]?(NSString*)data:data.description;
    self.aLabel.numberOfLines = 0;

    NSLog(@"data====%@",data);
}

@end
