#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface AbstractRepository : NSObject
{
	FMDatabase *db;
}

+ (NSString *)databaseFilename;
+ (NSString *) databasePath ;

@end