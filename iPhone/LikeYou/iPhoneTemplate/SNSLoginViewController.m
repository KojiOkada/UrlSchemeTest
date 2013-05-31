

#import "SNSLoginViewController.h"
#import "UIGlossyButton.h"
#import "SVProgressHUD.h"
#import "R9HTTPRequest.h"

@interface SNSLoginViewController ()

@end

@implementation SNSLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataSource = [NSMutableArray array];
    
    for(id obj in self.view.subviews){
       
        if([obj isKindOfClass:[UIGlossyButton class]]){
            UIGlossyButton *b = (UIGlossyButton*) obj;
            [b useWhiteLabel: YES]; b.tintColor = [UIColor blueColor];
            [b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
            [b setGradientType:kUIGlossyButtonGradientTypeLinearSmoothExtreme];
        }
    }
    
}

-(IBAction)FBButtonDidPush:(id)sender{
    [self getFacebook];
}
-(void)getFacebook{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];

    if (!appDelegate.session.isOpen) {
            appDelegate.session = [[FBSession alloc] init];
            [self fbOpen];
    }else{
        [self getMyInfo];
    }
}
-(void)fbOpen{
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.state != FBSessionStateCreatedTokenLoaded) {
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            [self getMyInfo];
        }];
    }else{
        [self getMyInfo];
    }
}
-(void)fbReadPermission{
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"email",
                            @"user_birthday",
                            @"user_location",
                            @"user_relationship_details",
                            nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
 
                                      [self getMyInfo];
                                  }];
    
}

-(void)fbRequestForMe{
    Reachability *curReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通信エラー" message:@"通信が可能な状態か確認してください。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    FBRequest *me = [FBRequest requestForMe];
    [me startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error){
  
        appDelegate.userInfo = (NSMutableDictionary*)result;
        [self sendAddUserRequestWithUserId:[result objectForKey:@"id"] snsType:kSNSTypeFaceBook];
    }];
}
-(void)getMyInfo{
    
    [SVProgressHUD show];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSString *strURL =[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",appDelegate.session.accessToken];
    
    R9HTTPRequest *HTTPRequest = [[R9HTTPRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    [HTTPRequest setHTTPMethod:@"GET"];
    
    [HTTPRequest setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString){
        
        if(responseString !=nil){
            id json=[responseString JSONValue];
            if(json==nil){
                return;
            }
   
            appDelegate.userInfo = (NSMutableDictionary*)json;
            [self sendAddUserRequestWithUserId:[json objectForKey:@"id"] snsType:kSNSTypeFaceBook];
            [SVProgressHUD dismiss];
        }
        
    }];

    [HTTPRequest setFailedHandler:^(NSError* error){
        
        NSLog(@"failString:%@",error);
        UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"通信エラー"
                                                     delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [SVProgressHUD dismiss];
        
    }];
    if ([HTTPRequest startRequest] == NO) {
        
    }
}

-(IBAction)closeDidPush:(id)sender{
    [self.view removeFromSuperview];
}

-(void)sendAddUserRequestWithUserId:(NSString*)userId snsType:(int)snsType{
    NSString *sns_type;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:snsType forKey:UD_SNS_TYPE];
    [ud setObject:userId forKey:UD_SNS_LOGIN_ID];
    [ud setObject:userId forKey:UD_SCREEN_NAME];
    [ud setInteger:snsType forKey:UD_SNS_TYPE];
     [ud setBool:YES forKey:UD_LOGIN];

        sns_type = @"facebook";
    [ud synchronize];
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    [app reloadView];
  }


-(IBAction)test:(id)sender{
    NSDate *date1 = [NSDate date];
    date1 = [[NSDate alloc] initWithTimeInterval: 60*60*24 sinceDate:date1];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strURL = @"http://pos-kp.ademo.s-cubism.com/api/pos_2.php";
    NSString *udid=[UIDevice currentDevice].uniqueIdentifier;
    
    // [req setHTTPBody:[[NSString stringWithFormat:@"table=%@&udid=%@&store_receipt=1&status=1&date=%@", tableName, udid, outputDateStr] dataUsingEncoding:NSUTF8StringEncoding]];
    //    status=1&table=storeDeliveryOrder&store_receipt=1&udid=e7bc5193e7245af384e16af6c8c74ed700000000&date=2013-05-28&
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
	NSString *outputDateFormatterStr = @"yyyy-MM-dd";
    [outputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
	[outputDateFormatter setDateFormat:outputDateFormatterStr];
	NSString *outputDateStr = [outputDateFormatter stringFromDate:date1];

    R9HTTPRequest *HTTPRequest = [[R9HTTPRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    [HTTPRequest setHTTPMethod:@"POST"];
    [HTTPRequest addBody:@"storeDeliveryOrder"forKey:@"table" ];
    [HTTPRequest addBody:udid forKey:@"udid"];
    [HTTPRequest addBody:@"1" forKey:@"status"];
    [HTTPRequest addBody:@"1" forKey:@"store_receipt"];
    [HTTPRequest addBody:outputDateStr forKey:@"date"];
    [HTTPRequest setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString){
        
        NSLog(@"%@ %@",responseHeader,responseString);
        if(responseString !=nil){
            id json=[responseString JSONValue];
            if(json==nil){
                return;
            }
        }
        
    }];
    
    [HTTPRequest setFailedHandler:^(NSError* error){
        
        NSLog(@"failString:%@",error);
        UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"通信エラー"
                                                     delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [SVProgressHUD dismiss];
        
    }];
    if ([HTTPRequest startRequest] == NO) {
        
    }
}
@end
