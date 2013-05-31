
#import "TwitterTestViewController.h"
#import "HistoryCell.h"
#import <Twitter/Twitter.h>
#import "BlocksKit.h"
#import "SVProgressHUD.h"
#import "Impression.h"
@interface TwitterTestViewController ()

@end

@implementation TwitterTestViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.title = @"一覧";
        self.tabBarItem.image = [UIImage imageNamed:@"list.png"];
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray array];
    _accountStore = [[ACAccountStore alloc] init];
    accountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    _likeKinds = [NSMutableArray array];
    
    XMDataManager *dm = [XMDataManager sharedManager];
    [dm loadPlist];
    
}
-(void)viewWillAppear:(BOOL)animated{

    [_likeKinds removeAllObjects];
    _dataSource = (NSMutableArray*)[XMDataManager getDictionaryListFrom:@"Urls" sort:nil pred:nil limit:0];
    NSLog(@"%@",[_dataSource description]);
    [self reload];
}

#pragma mark TalbeViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *OrderedCellIdentifier = @"HistoryCell";
    HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:OrderedCellIdentifier];
    
    if (cell == nil) {
        cell = (HistoryCell *)[[[NSBundle mainBundle] loadNibNamed:OrderedCellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    if([_dataSource count]==0){
        return cell;
    }else if([_dataSource count]==indexPath.row){
            [SVProgressHUD dismiss];
    }
    cell.selectedIndex = indexPath;

    NSDictionary* dic = [_dataSource objectAtIndex:indexPath.row];
    cell.scheme.text = [dic objectForKey:@"schems"];
    cell.Name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    cell.delegate = self;

    return cell;
}

#pragma mark TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_dataSource objectAtIndex:indexPath.row];
    NSString *scheme = [dic objectForKey:@"schems"];
    NSLog(@"%@",scheme);
    NSURL *url = [NSURL URLWithString:scheme];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark --cell Delegate
-(void)sendFriendImpressionForKey:(NSString*)key value:(BOOL)value indexPath:(NSIndexPath*)indexPath{
    
    NSDictionary * dic = [_dataSource objectAtIndex:indexPath.row];
    
    NSString *snsType;
    NSString *user_id;
    user_id = [dic objectForKey:@"id"];
    snsType = @"facebook";

    NSLog(@"%@",key);
    NSDictionary *param = @{@"uuid":@"1234",@"user_id":user_id,@"sns_type":snsType,@"key":key};
    
    XMDataManager *dm = [XMDataManager sharedManager];
    [dm addImpression:param target:self];
}

#pragma mark ButtonAciont
-(IBAction)footerViewDidPush:(id)sender{

}
-(IBAction)logoutDidPush:(id)sender{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app logoutAction];
}
#pragma mark Reload
-(void)reload{
    [_tableView reloadData];
}

@end
