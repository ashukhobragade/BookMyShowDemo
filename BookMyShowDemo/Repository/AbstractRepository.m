#import "AbstractRepository.h"
#import "FMDatabaseAdditions.h"
#import "AppDelegate.h"

@implementation AbstractRepository

+ (NSString *) databaseFilename {
	
	return @"bookmyshow.sqlite";
	
}

+ (NSString *) databasePath {
	
	NSString *filename = [AbstractRepository databaseFilename];
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString * dbfilePath = [documentsDirectory stringByAppendingPathComponent:filename];
	return dbfilePath;
	
}

- (id)init {
	
	if (self = [super init]) {
		
		NSString *dbPath = [AbstractRepository databasePath];
		db = [FMDatabase databaseWithPath:dbPath];
		[db setLogsErrors:YES];
		[db open];
	
    }
	
	return self;
	
}

@end