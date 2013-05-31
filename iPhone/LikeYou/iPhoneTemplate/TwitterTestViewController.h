

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import "SNSLoginViewController.h"
#import "Reachability.h"
@interface TwitterTestViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    ACAccountType *accountType;
    ACAccount *account;
}
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *accounts;
@property (nonatomic,retain) NSMutableArray *likeKinds;
@property (nonatomic,retain) ACAccountStore *accountStore;
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) IBOutlet UIView *footerView;
@property (nonatomic,retain) NSMutableString *fb_last_id;
@property (nonatomic,retain) NSMutableString *tw_last_id;
@property (nonatomic,assign) int fbPage;
@property (nonatomic,assign) int cursor;
@property (strong, nonatomic) SNSLoginViewController *snsView;
-(void)reload;
@end
