

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import "Reachability.h"
@interface SNSLoginViewController : UIViewController{
    ACAccountType *accountType;
    ACAccount *account;
}
@property (nonatomic,retain) NSMutableArray *accounts;
@property (nonatomic,retain) ACAccountStore *accountStore;
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,weak) IBOutlet UITextView *textView;
-(IBAction)TWButtonDidPush:(id)sender;
-(IBAction)FBButtonDidPush:(id)sender;

@end

