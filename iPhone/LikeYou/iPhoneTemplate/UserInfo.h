

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * blood_type;
@property (nonatomic, retain) NSString * facebook_id;
@property (nonatomic, retain) NSString * facebook_name;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * lang;
@property (nonatomic, retain) NSString * likeYou_id;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * target_gender;
@property (nonatomic, retain) NSString * twitter_id;
@property (nonatomic, retain) NSString * twitter_name;
@property (nonatomic, retain) NSNumber * twitter_Friend_count;
@property (nonatomic, retain) NSNumber * fb_friend_count;

@end
