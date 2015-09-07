//
//  PlaceDetailsRepository.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "PlaceDetailsRepository.h"

@implementation PlaceDetailsRepository

-(BOOL) insertPlaceData :(SearchedModel*) searchedModel{
    
    NSString *insertQuery = @"insert into place_details (searchedModelId,searchedModelName,searchedModelAddress,searchedModelImageUrl,searchedModelLat,searchedModelLon) Values(?,?,?,?,?,?)";
    
    //// Insert  Details ////
    return	[db executeUpdate:insertQuery,[NSString stringWithFormat:@"%@", searchedModel.searchedModelId],
             [NSString stringWithFormat:@"%@", searchedModel.searchedModelName],
             [NSString stringWithFormat:@"%@", searchedModel.searchedModelAddress],
             [NSString stringWithFormat:@"%@", searchedModel.searchedModelImageUrl],
             [NSString stringWithFormat:@"%@", searchedModel.searchedModelLat],
             [NSString stringWithFormat:@"%@", searchedModel.searchedModelLon]];
    
}


-(NSMutableArray*) getUserPlaceLists  {
    
    NSMutableArray *placeListArray = [[NSMutableArray alloc] init];
    
    NSString *selectQuery = @"select * from place_details";
    
    FMResultSet *rs = [db executeQuery:selectQuery];
    
    while([rs next])
    {
        SearchedModel *searchedModel = [[SearchedModel alloc] init];
        
        
        searchedModel.searchedModelId = [rs stringForColumn:@"searchedModelId"];
        searchedModel.searchedModelName = [rs stringForColumn:@"searchedModelName"];
        searchedModel.searchedModelAddress = [rs stringForColumn:@"searchedModelAddress"];
        searchedModel.searchedModelImageUrl = [rs stringForColumn:@"searchedModelImageUrl"];
        searchedModel.searchedModelLat = [rs stringForColumn:@"searchedModelLat"];
        searchedModel.searchedModelLon = [rs stringForColumn:@"searchedModelLon"];
        
        searchedModel.photoRefrenceArray =[self getPlaceImagesWithID:searchedModel.searchedModelId];
        
        [placeListArray addObject:searchedModel];
    }
    
    NSLog(@"%lu",(unsigned long)placeListArray.count);
    
    return placeListArray;
}

-(BOOL) isPlacePresentAlreadyWithSearchedModelId:(NSString *)searchedModelId {
    
    BOOL result = NO;
    
    NSString *selectQuery = @"select * from place_details WHERE searchedModelId=?";
    
    FMResultSet *rs = [db executeQuery:selectQuery,searchedModelId];
    
    while([rs next]){
        
        result= YES;
    }
    
    return result;
}

-(BOOL) deletePlace:(SearchedModel*) searchedModel
{
    NSString *deleteQuery = [NSString stringWithFormat:@"delete from place_details where searchedModelId = '%@'",searchedModel.searchedModelId];
    
    BOOL result = [db executeUpdate:deleteQuery];
    
    return result;
}

-(void) insertSearchedModelImageData :(SearchedModel*) searchedModel{
    
    NSString *insertQuery = @"insert into Images (searchedModelId, photoRef ) Values(?,? )" ;
 
    for (NSString *photoRef in searchedModel.photoRefrenceArray) {
        
        [db executeUpdate:insertQuery,[NSString stringWithFormat:@"%@", searchedModel.searchedModelId],
         [NSString stringWithFormat:@"%@",photoRef]];
    }
}

-(NSMutableArray*) getPlaceImagesWithID:(NSString *)searchedModelId;
 {
    
    NSMutableArray *photoRefArray = [[NSMutableArray alloc] init];
    
    NSString *selectQuery = @"select * from Images WHERE searchedModelId=?";
    
    FMResultSet *rs = [db executeQuery:selectQuery,searchedModelId];
    
    while([rs next]){
        
        [photoRefArray addObject:[rs stringForColumn:@"photoRef"]];
    }
    
    return photoRefArray;
}


-(BOOL) deletePlacePhotoRef:(SearchedModel*) searchedModel
{
    NSString *deleteQuery = [NSString stringWithFormat:@"delete from Images where searchedModelId = '%@'",searchedModel.searchedModelId];
    
    BOOL result = [db executeUpdate:deleteQuery];
    
    return result;
}
@end
