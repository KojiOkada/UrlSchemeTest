

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "TwitterTestViewController.h"
#import "SNSLoginViewController.h"
#import "webViewController.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

}
@property (strong, nonatomic) FBSession *session;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) TwitterTestViewController *twitter;
@property (strong, nonatomic) webViewController *webview;
@property (strong, nonatomic) SNSLoginViewController *snsView;

@property (strong, nonatomic) NSMutableDictionary *userInfo;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
-(void)reloadView;
-(void)alertShow;
-(void)logoutAction;
@end

enum kSNSType {
    kSNSTypeFaceBook = 0,
    kSNSTypeTwitter = 1,
};