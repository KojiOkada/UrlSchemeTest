

#import "XMDataManager.h"
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "NSManagedObjectContextExtra.h"
#import "UserInfo.h"
#import "Impression.h"
#import "SVProgressHUD.h"
#import "LikeKind.h"
#import "Urls.h"

@implementation XMDataManager

static XMDataManager* sharedInstance = nil;

+(XMDataManager*)sharedManager{
    
    if(!sharedInstance){
        sharedInstance = [[XMDataManager alloc]init];
    }
    
    return sharedInstance;
}

-(id)init{
    
    self = [super init];
    if(!self){
        return nil;
    }
    
    return self;
}

+(NSManagedObjectContext *)managedObjectContext{
        
        AppDelegate *delegate=[UIApplication sharedApplication].delegate;
        return delegate.managedObjectContext;
    }
    
+(NSArray *)getDataListFrom:(NSString *)entityName
sort:(NSSortDescriptor *)sort
pred:(NSPredicate *)pred
limit:(int)limit
    {
        
        NSManagedObjectContext* managedObjectContex=[NSManagedObjectContext managedObjectContextForCurrentThread];
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
 
        NSEntityDescription *entityDescription;
        entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContex];
        [fetchRequest setEntity:entityDescription];
        if(sort!=nil){
            NSArray *sortDescriptors;
            
            sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
        }else{
            NSArray *sortDescriptors;
            sortDescriptors = [[NSArray alloc] initWithObjects: nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
        }
        
        if(pred!=nil)[fetchRequest setPredicate:pred];
        
        if(limit>0)[fetchRequest setFetchBatchSize:limit];
        
        NSFetchedResultsController *resultsController;
        
        resultsController = [[NSFetchedResultsController alloc]
                             initWithFetchRequest:fetchRequest
                             managedObjectContext:managedObjectContex
                             sectionNameKeyPath:nil
                             cacheName:entityName];
        
        NSError* error = nil;
        if (![resultsController performFetch:&error]) {
            abort();
        }
        
        NSArray *result = resultsController.fetchedObjects ;
        resultsController=nil;
        
        managedObjectContex=nil;
        
        return result;
    }

+(NSUInteger)getCountFrom:(NSString *)entityName pred:(NSPredicate *)pred managedContext:managedContextForThread{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityDescription;
        entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedContextForThread];
        [fetchRequest setEntity:entityDescription];
        [fetchRequest setIncludesSubentities:NO];
        
        if(pred!=nil)[fetchRequest setPredicate:pred];
        
        NSError* error = nil;
        NSUInteger count = [managedContextForThread countForFetchRequest:fetchRequest error:&error];
        
        if(count == NSNotFound){
            count = 0;
        }
        return count;
    }
+(NSArray *)getDataListFrom:(NSString *)entityName
sort:(NSSortDescriptor *)sort
pred:(NSPredicate *)pred
limit:(int)limit managedContext:managedContextForThread
    {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityDescription;
        entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedContextForThread];
        [fetchRequest setEntity:entityDescription];
        if(sort!=nil){
            NSArray *sortDescriptors;
            sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
        }else{
            NSArray *sortDescriptors;
            sortDescriptors = [[NSArray alloc] initWithObjects: nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
        }
        
        if(pred!=nil)[fetchRequest setPredicate:pred];
        if(limit>0)[fetchRequest setFetchBatchSize:limit];
        

        NSFetchedResultsController *resultsController;
        
        resultsController = [[NSFetchedResultsController alloc]
                             initWithFetchRequest:fetchRequest
                             managedObjectContext:managedContextForThread
                             sectionNameKeyPath:nil
                             cacheName:entityName];
        

        NSError* error = nil;
        if (![resultsController performFetch:&error]) {
            abort();
        }
        
        NSArray *result = resultsController.fetchedObjects ;
        resultsController=nil;
        
        return result;
}
    
+(NSArray *)getDataListFrom:(NSString *)entityName sort:(NSSortDescriptor *)sort
pred:(NSPredicate *)pred offset:(NSUInteger)offset limit:(NSUInteger)limit managedContext:managedContextForThread
    {

        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDescription;
        entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedContextForThread];
        [fetchRequest setEntity:entityDescription];
        if(sort!=nil){
            NSArray *sortDescriptors;
            sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
        }
        if(pred!=nil){
            [fetchRequest setPredicate:pred];
        }
        
        [fetchRequest setFetchBatchSize:limit];
        [fetchRequest setFetchLimit:limit];
        [fetchRequest setFetchOffset:offset];
        
        NSFetchedResultsController *resultsController;
        
        resultsController = [[NSFetchedResultsController alloc]
                             initWithFetchRequest:fetchRequest
                             managedObjectContext:managedContextForThread
                             sectionNameKeyPath:nil
                             cacheName:entityName];
        
        NSError* error = nil;
        if (![resultsController performFetch:&error]) {
            abort();
        }
        
        NSArray *result = resultsController.fetchedObjects ;
        resultsController=nil;
        
        return result;
    }
    
+(NSArray *)getDictionaryListFrom:(NSString *)entityName
                       sort:(NSSortDescriptor *)sort
                       pred:(NSPredicate *)pred
                      limit:(int)limit
{
    NSManagedObjectContext* managedObjectContex=[NSManagedObjectContext managedObjectContextForCurrentThread];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription;
    entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContex];
    [fetchRequest setEntity:entityDescription];
    if(sort!=nil){
        NSArray *sortDescriptors;
        sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }else{
        NSArray *sortDescriptors;
        sortDescriptors = [[NSArray alloc] initWithObjects: nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    
    if(pred!=nil)[fetchRequest setPredicate:pred];
    
    if(limit>0)[fetchRequest setFetchBatchSize:limit];
    [fetchRequest setResultType:NSDictionaryResultType];

    NSFetchedResultsController *resultsController;
    
    resultsController = [[NSFetchedResultsController alloc]
                         initWithFetchRequest:fetchRequest
                         managedObjectContext:managedObjectContex
                         sectionNameKeyPath:nil
                         cacheName:entityName];
    

    NSError* error = nil;
    if (![resultsController performFetch:&error]) {
        abort();
    }
    
    NSArray *result = resultsController.fetchedObjects ;
    resultsController=nil;
    
    return result;
}
+(void)deleteAllRecordWithName:(NSString*)ename managedContext:managedContextForThread{
    
        @autoreleasepool {
            
            NSArray *arr = [XMDataManager getDataListFrom:ename sort:nil pred:nil limit:0 managedContext:managedContextForThread];
            for (int i=0; i<[arr count]; i++) {
                NSManagedObject *mo=[arr objectAtIndex:i];
                [managedContextForThread deleteObject:mo];
            }
            NSError *error = nil;
            [NSManagedObjectContext save:&error];
            if (error) {
                NSLog(@"DELETE ERROR: %@", error);
            } else {
                //NSLog(@"DELETED - %@", ename);
            }
            arr=nil;
        }
}
    
+(void)showEntityArray:(NSArray *)arr{
        for (int i=0; i<[arr count]; i++) {
            NSManagedObject *obj=[arr objectAtIndex:i];
            NSDictionary *prop=[obj.entity attributesByName];
            NSLog(@"%@",obj.entity.name);
            for (id e in prop){
                NSLog(@"	%@ : %@",e,[obj valueForKey:e]);
            }
        }
}
#pragma mark --userMethod--
-(void)removeFile:(NSString *)fileName{
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSArray *filePaths =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir =[filePaths objectAtIndex:0];
	NSString *toPath =
	[documentDir stringByAppendingPathComponent:fileName];
	[fileManager removeItemAtPath:toPath error:nil];
	
}

-(void)addImpression:(NSDictionary*)dic target:(id)target{
    NSManagedObjectContext* managedContext=[NSManagedObjectContext managedObjectContextForCurrentThread];
    NSString *userId;
    if([[dic objectForKey:@"user_id"]isKindOfClass:[NSString class]]){
        userId = [dic objectForKey:@"user_id"];
    }else{
        userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"user_id"]];
    }
    
    //◎が存在していた場合は○に変更する
    if([[dic objectForKey:@"key"]intValue]==0){
        NSPredicate *exPred = [NSPredicate predicateWithFormat:@"key=0"];
        NSArray *array = [XMDataManager getDataListFrom:@"Impression" sort:nil pred:exPred limit:0];
        
        for(Impression *imp in array){
            imp.key = @"1";
        }
            [NSManagedObjectContext save:nil];
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"user_id=%@",userId];
    NSArray* aArray=[XMDataManager getDataListFrom:@"Impression" sort:nil pred:pred limit:0 managedContext:managedContext];
    Impression *imp;
    if([aArray count]==0){
        imp = [NSEntityDescription insertNewObjectForEntityForName:@"Impression" inManagedObjectContext:managedContext];
    }else{
        imp =[aArray objectAtIndex:0];
    }
    
    imp.uuid =[dic objectForKey:@"uuid"];
    imp.user_id = userId;
    imp.sns_type = [dic objectForKey:@"sns_type"];
    imp.key = [dic objectForKey:@"key"];
    NSLog(@"%@",[dic objectForKey:@"key"]);
    NSError *error = nil;
    [NSManagedObjectContext save:&error];
    managedContext=nil;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataupdate" object:target];
}
-(void)loadPlist{

    
    NSManagedObjectContext* managedContext=[NSManagedObjectContext managedObjectContextForCurrentThread];
    NSArray* aArray=[XMDataManager getDataListFrom:@"Urls" sort:nil pred:nil limit:0 managedContext:managedContext];

    if([aArray count]>0){
        return;
    }

    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"URL" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray* list = [dic objectForKey:@"URLS"];
    
    for(NSDictionary *dic in list){
        Urls *url = [NSEntityDescription insertNewObjectForEntityForName:@"Urls" inManagedObjectContext:managedContext];
        url.name =[dic objectForKey:@"name"];
        url.display = [dic objectForKey:@"display"];
        url.schems = [dic objectForKey:@"scheme"];
    }
    
    NSError *error = nil;
    [NSManagedObjectContext save:&error];
    managedContext=nil;
    
}
#pragma mark --sendResult
-(NSString*)jsonStringFromDataList:(NSString*)entityName pred:(NSPredicate *)pred{
    NSArray *array = [XMDataManager getDictionaryListFrom:entityName sort:nil pred:pred limit:0];
    NSString *str = [array JSONRepresentation];
    return str;
    
}
@end
