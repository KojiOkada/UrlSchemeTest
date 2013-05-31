

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Impression : NSManagedObject

@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * sns_type;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * value;

@end
