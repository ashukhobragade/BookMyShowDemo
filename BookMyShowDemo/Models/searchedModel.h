//
//  searchedModel.h
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchedModel : NSObject

@property (nonatomic, strong) NSString *searchedModelId;
@property (nonatomic, strong) NSString *searchedModelImageUrl;
@property (nonatomic, strong) NSString *searchedModelName;
@property (nonatomic, strong) NSString *searchedModelAddress;
@property (nonatomic, strong) NSString *searchedModelLat;
@property (nonatomic, strong) NSString *searchedModelLon;
@property (nonatomic, assign) BOOL open_now;
@property (nonatomic, strong) NSArray *photoRefrenceArray;

+(NSMutableArray *)getSearchedModelArray:(NSDictionary *)response;


+(BOOL) insertPlaceData :(SearchedModel*) searchedModel;

+(NSMutableArray*) getUserPlaceLists;

+(BOOL) isPlacePresentAlreadyWithSearchedModelId:(NSString *)searchedModelId;

+(BOOL) deletePlace:(SearchedModel*) searchedModel;

+(void) insertSearchedModelImageData :(SearchedModel*) searchedModel;

+(NSMutableArray*) getPlaceImagesWithID:(NSString *)searchedModelId;

+(BOOL) deletePlacePhotoRef:(SearchedModel*) searchedModel;

@end
