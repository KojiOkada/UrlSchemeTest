//
//  Urls.h
//  LikeYou
//
//  Created by システム管理者 on 13/05/31.
//  Copyright (c) 2013年 koji.Okada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Urls : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * display;
@property (nonatomic, retain) NSString * schems;
@property (nonatomic, retain) NSNumber * result;

@end
