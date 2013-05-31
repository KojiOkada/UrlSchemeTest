//
//

#import <UIKit/UIKit.h>
#import "webViewController.h"


@interface webViewController : UIViewController<UIWebViewDelegate> {

	IBOutlet UIWebView *webView;
	IBOutlet UINavigationItem *naviitem;
	NSString *url;
	NSString *pagetitle;
}

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *pagetitle;
@property (nonatomic, retain) UINavigationItem *naviitem;
@property (nonatomic, retain) UIWebView *webView;

@end
