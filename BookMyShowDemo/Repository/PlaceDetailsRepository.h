//
//  PlaceDetailsRepository.h
//  BookMyShowDemo
//
//  Created by AshU on 9/4/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "AbstractRepository.h"
#import "SearchedModel.h"

@interface PlaceDetailsRepository : AbstractRepository

-(BOOL) insertPlaceData :(SearchedModel*) searchedModel;

-(NSMutableArray*) getUserPlaceLists;

-(BOOL) isPlacePresentAlreadyWithSearchedModelId:(NSString *)searchedModelId;

-(BOOL) deletePlace:(SearchedModel*) searchedModel;

-(void) insertSearchedModelImageData :(SearchedModel*) searchedModel;

-(NSMutableArray*) getPlaceImagesWithID:(NSString *)searchedModelId;

-(BOOL) deletePlacePhotoRef:(SearchedModel*) searchedModel;


@end
