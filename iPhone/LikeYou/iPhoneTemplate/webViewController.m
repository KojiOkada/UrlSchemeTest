
#import "webViewController.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
@implementation webViewController

@synthesize url, pagetitle, naviitem, webView;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.title = @"おすすめ";
        self.tabBarItem.image = [UIImage imageNamed:@"star.png"];
        self.view = webView;
    }
    return self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

    Reachability *curReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通信エラー" message:@"通信が可能な状態か確認してください。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [SVProgressHUD show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dismiss {
    [SVProgressHUD dismiss];
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) cancel {
	[self dismiss];
}

- (void)pageLoad {
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];  
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.naviitem.title = pagetitle;
	webView.scalesPageToFit = YES;
	webView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
	[self pageLoad];

}

@end
