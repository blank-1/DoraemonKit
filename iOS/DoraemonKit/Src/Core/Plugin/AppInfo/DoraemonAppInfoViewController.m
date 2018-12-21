//
//  DoraemonAppInfoViewController.m
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2018/4/13.
//

#import "DoraemonAppInfoViewController.h"
#import "DoraemonAppInfoCell.h"
#import "DoraemonDefine.h"
#import "DoraemonAppInfoUtil.h"
#import "Doraemoni18NUtil.h"
#import "UIView+Doraemon.h"
#import "UIColor+Doraemon.h"

@interface DoraemonAppInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DoraemonAppInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = DoraemonLocalizedString(@"App基本信息");
    
    //获取手机型号
    NSString *iphoneType = [DoraemonAppInfoUtil iphoneType];
    //获取手机系统版本
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    //获取bundle id
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    
    //获取App版本号
    NSString *bundleVersionCode = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
    
    //获取App版本Code
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    //获取手机是否有地理位置权限
    NSString *locationAuthority = [DoraemonAppInfoUtil locationAuthority];
    
    //获取网络权限
    NSString *netAuthority = [DoraemonAppInfoUtil netAuthority];
    
    //获取push权限
    NSString *pushAuthority = [DoraemonAppInfoUtil pushAuthority];
    
    //获取拍照权限
    NSString *cameraAuthority = [DoraemonAppInfoUtil cameraAuthority];
    
    //获取麦克风权限
    NSString *audioAuthority = [DoraemonAppInfoUtil audioAuthority];
    
    //获取相册权限
    NSString *photoAuthority = [DoraemonAppInfoUtil photoAuthority];
    
    //获取通讯录权限
    NSString *addressAuthority = [DoraemonAppInfoUtil addressAuthority];
    
    //获取日历权限
    NSString *calendarAuthority = [DoraemonAppInfoUtil calendarAuthority];
    
    //获取提醒事项权限
    NSString *remindAuthority = [DoraemonAppInfoUtil remindAuthority];
    
    NSArray *dataArray = @[
                            @{
                               @"title":DoraemonLocalizedString(@"手机信息"),
                               @"array":@[@{
                                            @"title":DoraemonLocalizedString(@"手机型号"),
                                            @"value":iphoneType
                                            },
                                        @{
                                            @"title":DoraemonLocalizedString(@"系统版本"),
                                            @"value":phoneVersion
                                            }
                                     ]
                               },
                            @{
                                @"title":DoraemonLocalizedString(@"App信息"),
                                @"array":@[@{
                                               @"title":@"Bundle ID",
                                               @"value":bundleId
                                               },
                                           @{
                                               @"title":@"version",
                                               @"value":bundleVersion
                                               },
                                           @{
                                               @"title":@"versionCode",
                                               @"value":bundleVersionCode
                                               }
                                           ]
                                },
                            @{
                                @"title":DoraemonLocalizedString(@"权限信息"),
                                @"array":@[@{
                                               @"title":DoraemonLocalizedString(@"地理位置权限"),
                                               @"value":locationAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"网络权限"),
                                               @"value":netAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"推送权限"),
                                               @"value":pushAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"相机权限"),
                                               @"value":cameraAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"麦克风权限"),
                                               @"value":audioAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"相册权限"),
                                               @"value":photoAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"通讯录权限"),
                                               @"value":addressAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"日历权限"),
                                               @"value":calendarAuthority
                                               },
                                           @{
                                               @"title":DoraemonLocalizedString(@"提醒事项权限"),
                                               @"value":remindAuthority
                                               }
                                           ]
                                }
                            ];
    _dataArray = dataArray;
    

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, self.view.doraemon_height-self.bigTitleView.doraemon_bottom) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0.;
    self.tableView.estimatedSectionFooterHeight = 0.;
    self.tableView.estimatedSectionHeaderHeight = 0.;
    [self.view addSubview:self.tableView];
}

- (BOOL)needBigTitleView{
    return YES;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _dataArray[section][@"array"];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DoraemonAppInfoCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kDoraemonSizeFrom750(120);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.doraemon_width, kDoraemonSizeFrom750(120))];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDoraemonSizeFrom750(32), 0, DoraemonScreenWidth-kDoraemonSizeFrom750(32), kDoraemonSizeFrom750(120))];
    NSDictionary *dic = _dataArray[section];
    titleLabel.text = dic[@"title"];
    titleLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750(28)];
    titleLabel.textColor = [UIColor doraemon_black_3];
    [sectionView addSubview:titleLabel];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"httpcell";
    DoraemonAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[DoraemonAppInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSArray *array = _dataArray[indexPath.section][@"array"];
    NSDictionary *item = array[indexPath.row];
    [cell renderUIWithData:item];
    return cell;
}



@end