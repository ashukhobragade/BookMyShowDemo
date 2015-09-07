//
//  searchedModel.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "SearchedModel.h"
#import "PlaceDetailsRepository.h"
@implementation SearchedModel


- (NSDictionary *)jsonMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"searchedModelId",@"id",
            @"searchedModelImageUrl",@"icon",
            @"searchedModelName",@"name",
             @"searchedModelAddress",@"vicinity",
            @"open_now",@"opening_hours",
            @"photoRefrenceArray",@"photos",
            @"geometry",@"geometry"
            ,nil];
    
}

+(SearchedModel *)searchedModelFromDictionary:(NSDictionary *)dictionary {
    
    SearchedModel *searchedModel = [[SearchedModel alloc] init];
    
    NSDictionary *mapping = [searchedModel jsonMapping];
    
    for (NSString *attribute in [mapping allKeys]) {
       
        if ([attribute isEqualToString:@"geometry"] && [[dictionary objectForKey:attribute] isKindOfClass:[NSDictionary class]] ) {
            
            NSDictionary *dict =[[dictionary objectForKey:attribute] objectForKey:@"location"];

            searchedModel.searchedModelLat  =[dict objectForKey:@"lat"];
            searchedModel.searchedModelLon  =[dict objectForKey:@"lng"];
            
        }
        else if ([dictionary objectForKey:attribute]!=nil&&([[dictionary objectForKey:attribute] isKindOfClass:[NSDictionary class]])) {
            
            NSString *classProperty = [mapping objectForKey:attribute];
            NSString *attributeValue = [[dictionary objectForKey:attribute] objectForKey:@"open_now"];
            
            [searchedModel setValue:attributeValue forKeyPath:classProperty];
            
        }
        else if ([dictionary objectForKey:attribute]!=nil&&([[dictionary objectForKey:attribute] isKindOfClass:[NSArray class]])&&!([[dictionary objectForKey:attribute] isKindOfClass:[NSNull class]])) {
            
            NSMutableArray *photoRef = [[NSMutableArray alloc] init];
                 NSString *classProperty = [mapping objectForKey:attribute];
            
            for (NSDictionary *dict in [dictionary objectForKey:attribute]) {
                
           
                NSString *attributeValue = [dict objectForKey:@"photo_reference"];
                
                [photoRef addObject:attributeValue];
                
            }
            [searchedModel setValue:photoRef forKeyPath:classProperty];

        }
        else if ([dictionary objectForKey:attribute]!=nil&&!([[dictionary objectForKey:attribute] isKindOfClass:[NSNull class]])) {
           
            NSString *classProperty = [mapping objectForKey:attribute];
            NSString *attributeValue = [dictionary objectForKey:attribute];
            
            [searchedModel setValue:attributeValue forKeyPath:classProperty];
            
        }
    }
    
    return searchedModel;
}

+(NSMutableArray *)getSearchedModelArray:(NSDictionary *)response{
    
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in [response objectForKey:@"results"]) {
        
        SearchedModel *model=[SearchedModel searchedModelFromDictionary:dict];
        
        [searchArray addObject:model];
    }

    return searchArray;
}


+(BOOL) insertPlaceData :(SearchedModel*) searchedModel{
    
    PlaceDetailsRepository *placeDetailsRepository =[[PlaceDetailsRepository alloc] init];
    
    return [placeDetailsRepository insertPlaceData:searchedModel];
}

+(NSMutableArray*) getUserPlaceLists{
    
    PlaceDetailsRepository *placeDetailsRepository =[[PlaceDetailsRepository alloc] init];
    
    return [placeDetailsRepository getUserPlaceLists];
}

+(BOOL) isPlacePresentAlreadyWithSearchedModelId:(NSString *)searchedModelId{
    
    PlaceDetailsRepository *placeDetailsRepository =[[PlaceDetailsRepository alloc] init];
    
    return [placeDetailsRepository isPlacePresentAlreadyWithSearchedModelId:searchedModelId];
}

+(BOOL) deletePlace:(SearchedModel*) searchedModel{
    
    PlaceDetailsRepository *placeDetailsRepository =[[PlaceDetailsRepository alloc] init];
    
    return [placeDetailsRepository deletePlace:searchedModel];
}


+(void) insertSearchedModelImageData :(SearchedModel*) searchedModel{
    
    PlaceDetailsRepository *placeDetailsRepository =[[PlaceDetailsRepository alloc] init];
    
    return [placeDetailsRepository insertSearchedModelImageData:searchedModel];
}


+(NSMutableArray*) getPlaceImagesWithID:(NSString *)searchedModelId;{
    
    PlaceDetailsRepository *placeDetailsRepository =[[PlaceDetailsRepository alloc] init];
    
    return [placeDetailsRepository getPlaceImagesWithID:searchedModelId];
}


+(BOOL) deletePlacePhotoRef:(SearchedModel*) searchedModel{
    
    PlaceDetailsRepository *placeDetailsRepository =[[PlaceDetailsRepository alloc] init];
    
    return [placeDetailsRepository deletePlacePhotoRef:searchedModel ];
}


@end
