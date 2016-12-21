# JDragonTableManager

iOS  UITableView的DataSource和delegate  优化封装

badge-pod badge-languages badge-platforms badge-mit


### user pod

```

pod 'JDragonTableManager','~> 0.0.2'


```


##基本使用

```
##Controller 方法
#import "JDragonTableManager.h"
#import "UITableView+JDragonTableManager.h"
@interface UITableViewController ()

@property (weak, nonatomic) IBOutlet UITableView   *aTableView;
@property (nonatomic,strong) JDragonTableManager   *tabDelagate;
@property (nonatomic,strong) JDragonTableManager   *tabDataSource;

@end

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

##Cell方法

#import "JDragonTableManager.h"
@interface aTableViewCell ()<JDTableManagerDelegate>

@end

@implementation aTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)PrepareToWithAppear:(NSObject *)data WithCurentVC:(UIViewController *)curentVC WithIndexPath:(NSIndexPath *)indexPath
{
    self.textLabel.text = [data isKindOfClass:[NSString class]]?(NSString*)data:data.description;

    NSLog(@"data====%@",data);
}
@end

```


##详细请看demo

