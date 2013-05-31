

#import <UIKit/UIKit.h>
@protocol HistoryCellDelegate<NSObject>
//-(void)tableViewCellAccessoryDidPush:(NSIndexPath*)indexPath;
-(void)sendFriendImpressionForKey:(NSString*)key value:(BOOL)value indexPath:(NSIndexPath*)indexPath;

@end
@interface HistoryCell : UITableViewCell
@property (nonatomic,retain) id<HistoryCellDelegate> delegate;
@property (nonatomic,retain) IBOutlet UILabel *Name;
@property (nonatomic,retain) IBOutlet UILabel *scheme;
@property (nonatomic,retain) NSIndexPath *selectedIndex;

@end
